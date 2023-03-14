import Combine
import Foundation

class AuthenticatorImpl: Authenticator {
    // MARK: - Initialiazer

    init(httpManager: HTTPManager, sessionTokenProvider: SessionTokenProvider) {
        self.httpManager = httpManager
        self.sessionTokenProvider = sessionTokenProvider
    }

    // MARK: - Internal
    
    var currentUserId: String? {
        session.value?.userId
    }
    
    func watchCurrentUserId() -> AnyPublisher<String?, Never> {
        session
            .map { $0?.userId }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func authenticate(
        userId: String
    ) {
        session.value = Session(
            userId: userId,
            tokens: nil
        )
    }
    
    func logOut() {
        session.value = nil
    }
    
    func markTokensAsInvalid() {
        session.value?.tokens = nil
    }
    
    func getAuthenticationState() async throws -> AuthenticationState {
        try await sharedTask.run {
            guard let session = self.session.value else {
                return .notAuthenticated
            }
            
            if let tokens = session.tokens, !tokens.accessToken.isExpired {
                return .authenticated(accessToken: tokens.accessToken.value)
            }
            
            let tokens = try await self.renewSession(session)
            self.session.value = session.with(tokens: tokens)
            return .authenticated(accessToken: tokens.accessToken.value)
        }
    }
    
    func watchAuthenticationState() -> AnyPublisher<AuthenticationState, Never> {
        session
            .map { $0?.tokens?.accessToken }
            .removeDuplicates()
            .map { accessToken -> AuthenticationState in
                if let accessToken = accessToken {
                    return .authenticated(accessToken: accessToken.value)
                } else {
                    return .notAuthenticated
                }
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private
    
    private let httpManager: HTTPManager
    private let sessionTokenProvider: SessionTokenProvider
    
    private let sharedTask = TaskHolder<AuthenticationState>()
    private let session = CurrentValueSubject<Session?, Never>(nil)
    
    /// - Throws: ``AuthenticationError``
    private func renewSession(_ session: Session) async throws -> SessionTokens {
        if let tokens = session.tokens, !tokens.refreshToken.isExpired {
            return try await fetchTokens(refreshToken: tokens.refreshToken)
        }
        return try await requireTokens(session: session)
    }
    
    /// - Throws: ``AuthenticationError``
    private func requireTokens(session: Session) async throws -> SessionTokens {
        let authTokens = await withCheckedContinuation { (continuation: CheckedContinuation<AuthTokens?, Never>) in
            sessionTokenProvider.provideTokens(forUserId: session.userId) { authTokens in
                continuation.resume(returning: authTokens)
            }
        }
        guard let authTokens = authTokens else {
            throw AuthenticationProviderFailedToProvideTokensError()
        }
        
        do {
            let accessToken = try Self.deserialize(token: authTokens.accessToken)
            let refreshToken = try Self.deserialize(token: authTokens.refreshToken)
            
            if refreshToken.isExpired {
                throw AuthenticationProviderDidProvideExpiredTokensError()
            } else if accessToken.isExpired {
                return try await fetchTokens(refreshToken: refreshToken)
            } else {
                return SessionTokens(accessToken: accessToken, refreshToken: refreshToken)
            }
        } catch let error as AuthenticationError {
            throw error
        } catch {
            throw UnknownAuthenticationError(underlyingError: error)
        }
    }
    
    /// - Throws: ``AuthenticationError``
    private func fetchTokens(refreshToken: Token) async throws -> SessionTokens {
        let request = RefreshTokenEndpoint.request(refreshToken: refreshToken.value)
        do {
            let response = try await httpManager.fetch(RefreshTokenEndpoint.Response.self, associatedTo: request)
            
            let accessToken = try Self.deserialize(token: response.accessToken)
            let refreshToken = try Self.deserialize(token: response.refreshToken)
            return SessionTokens(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
        } catch let error as HTTPError {
            if Self.isAuthorizationError(error) {
                throw AuthorizationDeniedError(reason: error)
            } else {
                throw FailedToRefreshTokensError(reason: error)
            }
        } catch let error as AuthenticationError {
            throw error
        } catch {
            throw UnknownAuthenticationError(underlyingError: error)
        }
    }
    
    private static func isAuthorizationError(_ error: HTTPError) -> Bool {
        switch error {
        case .transportError, .decodingError, .noSelf:
            return false
        case let .serverError(serverError):
            switch serverError {
            case .unauthorized:
                return true
            case .generic, .notFound, .unavailableService:
                return false
            }
        }
    }
    
    private static func deserialize(token: String) throws -> Token {
        do {
            let jwt = try decode(jwt: token)
            return Token(value: token, expiresAt: jwt.expiresAt)
        } catch {
            throw AuthenticationProviderDidProvideInvalidTokensError(reason: error)
        }
    }
}
