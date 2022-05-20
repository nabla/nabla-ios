import Foundation

class AuthenticatorImpl: Authenticator {
    // MARK: - Initialiazer

    init(httpManager: HTTPManager) {
        self.httpManager = httpManager
    }

    // MARK: - Internal
    
    func authenticate(
        userId: UUID,
        provider: SessionTokenProvider
    ) {
        self.provider = provider
        session = Session(userId: userId, tokens: nil)
        notifyTokensChanged()
    }
    
    func logOut() {
        session = nil
        provider = nil
    }
    
    func getAccessToken(handler: ResultHandler<AuthenticationState, NablaAuthenticationError>) {
        guard let session = session else {
            handler(.success(.notAuthenticated))
            return
        }
        
        if let tokens = session.tokens, !isExpired(tokens.accessToken) {
            handler(.success(.authenticated(accessToken: tokens.accessToken)))
            return
        }
        
        let task = makeOrReuseRenewSessionTask(session: session)
        task.addOnComplete { [session] result in
            switch result {
            case let .success(tokens):
                session.tokens = tokens
                handler(.success(.authenticated(accessToken: tokens.accessToken)))
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
        provider != nil
    }

    // MARK: - Private
    
    private enum Constants {
        static let tokenChangedNotification = Notification.Name(rawValue: "tokenChangedNotification")
    }
    
    private let notificationCenter = NotificationCenter()
    private let httpManager: HTTPManager
    
    private var provider: SessionTokenProvider?
    private var session: Session?
    private var renewTask: SharedTask<Result<Tokens, NablaAuthenticationError>>?
    
    private func isExpired(_ token: String) -> Bool {
        do {
            let jwt = try decode(jwt: token)
            guard let expiresAt = jwt.expiresAt else { return false }
            return expiresAt.isPast
        } catch {
            return true
        }
    }
    
    private func makeOrReuseRenewSessionTask(session: Session) -> SharedTask<Result<Tokens, NablaAuthenticationError>> {
        if let existing = renewTask {
            return existing
        }
        let renewTask = SharedTask<Result<Tokens, NablaAuthenticationError>> { [weak self] completion in
            guard let self = self else { return }
            self.renewSession(session) { result in
                completion(result)
                self.renewTask = nil
                self.notifyTokensChanged()
            }
        }
        self.renewTask = renewTask
        return renewTask
    }
    
    private func notifyTokensChanged() {
        notificationCenter.post(name: Constants.tokenChangedNotification, object: nil)
    }
    
    private func renewSession(_ session: Session, completion: @escaping (Result<Tokens, NablaAuthenticationError>) -> Void) {
        if let tokens = session.tokens, !isExpired(tokens.refreshToken) {
            fetchTokens(refreshToken: tokens.refreshToken, completion: completion)
            return
        }
        
        guard let provider = provider else {
            completion(.failure(.missingAuthenticationProvider))
            return
        }
        requireTokens(userId: session.userId, provider: provider, completion: completion)
    }
    
    private func requireTokens(userId: UUID, provider: SessionTokenProvider, completion: (Result<Tokens, NablaAuthenticationError>) -> Void) {
        provider.provideTokens(forUserId: userId) { token in
            if let token = token {
                completion(.success(token))
            } else {
                completion(.failure(.authenticationProviderFailedToProvideTokens))
            }
        }
    }
    
    private func fetchTokens(refreshToken: String, completion: @escaping (Result<Tokens, NablaAuthenticationError>) -> Void) {
        let request = RefreshTokenEndpoint.request(refreshToken: refreshToken)
        httpManager.fetch(RefreshTokenEndpoint.Response.self, associatedTo: request) { result in
            switch result {
            case let .failure(error):
                if Self.isAuthorizationError(error) {
                    completion(.failure(.authorizationDenied(error)))
                } else {
                    completion(.failure(.failedToRefreshTokens(error)))
                }
            case let .success(response):
                let tokens = Tokens(
                    accessToken: response.accessToken,
                    refreshToken: response.refreshToken
                )
                completion(.success(tokens))
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
}
