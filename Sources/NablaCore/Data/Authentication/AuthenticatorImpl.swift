import Combine
import Foundation

class AuthenticatorImpl: Authenticator {
    // MARK: - Initialiazer

    init(
        httpManager: HTTPManager,
        sessionTokenProvider: SessionTokenProvider,
        userRepository: UserRepository
    ) {
        self.httpManager = httpManager
        self.sessionTokenProvider = sessionTokenProvider
        self.userRepository = userRepository
    }

    // MARK: - Internal
    
    func logOut() {
        tokens.value = nil
    }
    
    func markTokensAsInvalid() {
        tokens.value = nil
    }
    
    func getAuthenticationState() async throws -> AuthenticationState {
        try await sharedTask.run {
            guard let user = self.userRepository.getCurrentUser() else {
                return .notAuthenticated
            }
            
            guard let currentTokens = self.tokens.value else {
                let newTokens = try await self.requireTokensFromHostApp(userId: user.id)
                self.tokens.send(newTokens)
                return .authenticated(accessToken: newTokens.accessToken.value)
            }
            
            if !currentTokens.accessToken.isExpired {
                return .authenticated(accessToken: currentTokens.accessToken.value)
            }
            
            let newTokens = try await self.renewTokens(userId: user.id, tokens: currentTokens)
            self.tokens.send(newTokens)
            return .authenticated(accessToken: newTokens.accessToken.value)
        }
    }
    
    func watchAuthenticationState() -> AnyPublisher<AuthenticationState, Never> {
        tokens
            .map { $0?.accessToken }
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
    private let userRepository: UserRepository
    
    private let sharedTask = TaskHolder<AuthenticationState>()
    private let tokens = CurrentValueSubject<SessionTokens?, Never>(nil)
    
    /// - Throws: ``AuthenticationError``
    private func renewTokens(userId: String, tokens: SessionTokens) async throws -> SessionTokens {
        if !tokens.refreshToken.isExpired {
            return try await refreshAccessToken(refreshToken: tokens.refreshToken)
        }
        return try await requireTokensFromHostApp(userId: userId)
    }
    
    /// - Throws: ``AuthenticationError``
    private func requireTokensFromHostApp(userId: String) async throws -> SessionTokens {
        let authTokens = await withCheckedContinuation { (continuation: CheckedContinuation<AuthTokens?, Never>) in
            sessionTokenProvider.provideTokens(forUserId: userId) { authTokens in
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
                return try await refreshAccessToken(refreshToken: refreshToken)
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
    private func refreshAccessToken(refreshToken: Token) async throws -> SessionTokens {
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
