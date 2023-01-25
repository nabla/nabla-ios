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
        session = nil
    }
    
    func getAccessToken() async throws -> AuthenticationState {
        guard let session = session else {
            return .notAuthenticated
        }
        
        if let tokens = session.tokens, !tokens.accessToken.isExpired {
            return .authenticated(accessToken: tokens.accessToken.value)
        }
        
        let task = await makeOrReuseRenewSessionTask(session: session)
        switch await task.result {
        case let .failure(error):
            if let authError = error as? AuthenticationError {
                throw authError
            } else {
                throw UnknownAuthenticationError(undelryingError: error)
            }
        case let .success(tokens):
            self.session = session.with(tokens: tokens)
            return .authenticated(accessToken: tokens.accessToken.value)
        }
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
    
    private var renewTaskHolder = TaskHolder<SessionTokens>()
    
    private var session: Session? {
        didSet { notifyTokensChanged(oldValue: oldValue?.tokens, newValue: session?.tokens) }
    }
    
    private func makeOrReuseRenewSessionTask(session: Session) async -> Task<SessionTokens, Error> {
        let taskId = session.tokens?.refreshToken.value ?? "nil-session-task-id"
        if let existing = await renewTaskHolder.getTask(withId: taskId) {
            return existing
        }
        return await renewTaskHolder.start(id: taskId, priority: .userInitiated) { [weak self] in
            guard let self = self else { throw AuthenticationInternalError(message: "`self` deallocated too early") }
            let tokens = try await self.renewSession(session)
            return tokens
        }
    }
    
    private func notifyTokensChanged(oldValue: SessionTokens?, newValue: SessionTokens?) {
        guard newValue != oldValue else { return }
        notificationCenter.post(name: Constants.tokenChangedNotification, object: nil)
    }
    
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
            session.provider.provideTokens(forUserId: session.userId) { authTokens in
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
            throw UnknownAuthenticationError(undelryingError: error)
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
            throw UnknownAuthenticationError(undelryingError: error)
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

/// Shares a single `Task` for a given identifier, even after completion.
/// If the task fails, it is released and the resut if not shared.
private actor TaskHolder<T> {
    // MARK: - Internal
    
    func getTask(withId id: String) -> Task<T, Error>? {
        tasks[id]
    }
    
    func start(id: String, priority: TaskPriority? = nil, operation: @escaping @Sendable () async throws -> T) -> Task<T, Error> {
        let task = Task<T, Error>(priority: priority) {
            do {
                return try await operation()
            } catch {
                tasks.removeValue(forKey: id)
                throw error
            }
        }
        tasks[id] = task
        return task
    }
    
    // MARK: - Private
    
    private var tasks = [String: Task<T, Error>]()
}
