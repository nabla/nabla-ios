import Foundation

class AuthenticatorImpl: Authenticator {
    // MARK: - Initialiazer

    init(httpManager: HTTPManager) {
        self.httpManager = httpManager
    }

    // MARK: - Internal
    
    func authenticate(
        userId: String,
        provider: SessionTokenProvider
    ) {
        session = Session(
            userId: userId,
            provider: provider,
            tokens: nil
        )
    }
    
    func logOut() {
        let oldTokens = session?.tokens
        session = nil
        notifyTokensChanged(oldValue: oldTokens, newValue: nil)
    }
    
    func getAccessToken(handler: ResultHandler<AuthenticationState, AuthenticationError>) {
        guard let session = session else {
            handler(.success(.notAuthenticated))
            return
        }
        
        if let tokens = session.tokens, !tokens.accessToken.isExpired {
            handler(.success(.authenticated(accessToken: tokens.accessToken.value)))
            return
        }
        
        let task = makeOrReuseRenewSessionTask(session: session)
        task.addOnComplete { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(tokens):
                let oldTokens = session.tokens
                session.tokens = tokens
                self.notifyTokensChanged(oldValue: oldTokens, newValue: tokens)
                handler(.success(.authenticated(accessToken: tokens.accessToken.value)))
            case let .failure(error):
                handler(.failure(error))
            }
        }
        task.resume()
    }
    
    func addObserver(_ observer: Any, selector: Selector) {
        notificationCenter.addObserver(
            observer,
            selector: selector,
            name: Constants.tokenChangedNotification,
            object: nil
        )
    }
    
    func removeObserver(_ observer: Any) {
        notificationCenter.removeObserver(
            observer,
            name: Constants.tokenChangedNotification,
            object: nil
        )
    }

    func isSessionInitialized() -> Bool {
        session != nil
    }

    // MARK: - Private
    
    private enum Constants {
        static let tokenChangedNotification = Notification.Name(rawValue: "tokenChangedNotification")
    }
    
    private let notificationCenter = NotificationCenter()
    private let httpManager: HTTPManager
    
    private var session: Session?
    private var renewTask: SharedTask<Result<SessionTokens, AuthenticationError>>?
    
    private func makeOrReuseRenewSessionTask(session: Session) -> SharedTask<Result<SessionTokens, AuthenticationError>> {
        if let existing = renewTask {
            return existing
        }
        let renewTask = SharedTask<Result<SessionTokens, AuthenticationError>> { [weak self] completion in
            guard let self = self else { return }
            self.renewSession(session) { result in
                completion(result)
                self.renewTask = nil
            }
        }
        self.renewTask = renewTask
        return renewTask
    }
    
    private func notifyTokensChanged(oldValue: SessionTokens?, newValue: SessionTokens?) {
        guard newValue != oldValue else { return }
        notificationCenter.post(name: Constants.tokenChangedNotification, object: nil)
    }
    
    private func renewSession(_ session: Session, completion: @escaping (Result<SessionTokens, AuthenticationError>) -> Void) {
        if let tokens = session.tokens, !tokens.refreshToken.isExpired {
            fetchTokens(refreshToken: tokens.refreshToken, completion: completion)
            return
        }
        requireTokens(session: session, completion: completion)
    }
    
    private func requireTokens(session: Session, completion: @escaping (Result<SessionTokens, AuthenticationError>) -> Void) {
        session.provider.provideTokens(forUserId: session.userId) { [weak self] authTokens in
            guard let self = self, let authTokens = authTokens else {
                return completion(.failure(AuthenticationProviderFailedToProvideTokensError()))
            }
            
            do {
                let accessToken = try Self.deserialize(token: authTokens.accessToken)
                let refreshToken = try Self.deserialize(token: authTokens.refreshToken)
                
                if refreshToken.isExpired {
                    completion(.failure(AuthenticationProviderDidProvideExpiredTokensError()))
                } else if accessToken.isExpired {
                    self.fetchTokens(refreshToken: refreshToken, completion: completion)
                } else {
                    let tokens = SessionTokens(accessToken: accessToken, refreshToken: refreshToken)
                    completion(.success(tokens))
                }
            } catch let error as AuthenticationError {
                completion(.failure(error))
            } catch {
                completion(.failure(UnknownAuthenticationError(undelryingError: error)))
            }
        }
    }
    
    private func fetchTokens(refreshToken: Token, completion: @escaping (Result<SessionTokens, AuthenticationError>) -> Void) {
        let request = RefreshTokenEndpoint.request(refreshToken: refreshToken.value)
        httpManager.fetch(RefreshTokenEndpoint.Response.self, associatedTo: request) { result in
            switch result {
            case let .failure(error):
                if Self.isAuthorizationError(error) {
                    completion(.failure(AuthorizationDeniedError(reason: error)))
                } else {
                    completion(.failure(FailedToRefreshTokensError(reason: error)))
                }
            case let .success(response):
                do {
                    let accessToken = try Self.deserialize(token: response.accessToken)
                    let refreshToken = try Self.deserialize(token: response.refreshToken)
                    let tokens = SessionTokens(
                        accessToken: accessToken,
                        refreshToken: refreshToken
                    )
                    completion(.success(tokens))
                } catch let error as AuthenticationError {
                    completion(.failure(error))
                } catch {
                    completion(.failure(UnknownAuthenticationError(undelryingError: error)))
                }
            }
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
