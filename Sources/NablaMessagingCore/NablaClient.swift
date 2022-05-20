import Foundation

private enum Constants {
    static let defaultName = "singleton"
}

/// You should always call``NablaClient.initialize`` as soon as possible.
/// Before any interaction with messaging features make sure you
/// successfully authenticated your user by calling ``NablaClient.shared.authenticate(provider:)``.
public class NablaClient {
    // MARK: - Initializer

    /// Create an instance of NablaClient to use.
    /// - Parameters:
    ///   - apiKey: Your organisation's API key (created online on Nabla dashboard).
    ///   - name: Namespace for your the stored objects.
    ///   - configuration: Optional API configuration. This is for internal usage and you should probably never pass any value.
    init(apiKey: String, name: String, configuration: Configuration? = nil) {
        container = CoreContainer(name: name, configuration: configuration ?? DefaultConfiguration())

        addHTTPHeader(name: HTTPHeaders.NablaApiKey, value: Self.formatApiKey(apiKey))
    }

    // MARK: - Public

    /// Shared instance of NablaClient client to use.
    /// Always call ``NablaClient.initialize(apiKey:)`` before accessing it.
    public static var shared: NablaClient {
        guard let shared = _shared else {
            fatalError("NablaClient.initialize(configuration:) must be called before accessing NablaClient.shared")
        }
        return shared
    }

    /// Shared instance initializer, you must call this method before accessing `NablaClient.shared`.
    /// You must call this method only once.
    /// - Parameters:
    ///   - apiKey: Your organisation's API key (created online on Nabla dashboard).
    ///   - configuration: Optional API configuration. This is for internal usage and you should probably never pass any value.
    public static func initialize(apiKey: String, configuration: Configuration? = nil) {
        guard _shared == nil else {
            assertionFailure("NablaClient.initialize(configuration:) can only be called once")
            return
        }
        _shared = NablaClient(
            apiKey: apiKey,
            name: Constants.defaultName,
            configuration: configuration ?? DefaultConfiguration()
        )
    }

    /// Authenticate the current user.
    /// - Parameters:
    ///   - userId: Identifies the user between sessions.
    ///   - provider: ``Tokens`` provider
    public func authenticate(
        userId: UUID,
        provider: SessionTokenProvider
    ) {
        if let currentUser = container.userRepository.getCurrentUser(), currentUser.id != userId {
            container.logger.info(message: "Authenticating a new user, will log previous one out first.")
            logOut()
        }
        container.userRepository.setCurrentUser(User(id: userId))
        container.authenticator.authenticate(userId: userId, provider: provider)
    }

    /// Log the current user out
    public func logOut() {
        container.userRepository.setCurrentUser(nil)
        container.authenticator.logOut()
        container.gqlStore.clearCache { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                break
            case let .failure(error):
                self.container.logger.error(message: "Failed to clear cache on logout: \(error)")
            }
        }
    }

    /// Any ``RefetchTrigger`` will tell the SDK to update watchers with the latest server data.
    /// It is a common practice to add some ``NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)``
    /// in order to refresh the on screen information when your application comes back to foreground
    /// - Parameter triggers: The triggers to add.
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        container.gqlClient.addRefetchTriggers(triggers)
    }

    /// Add default HTTP Headers to calls. This is for internal usage and you should probably never call it.
    /// - Parameters:
    ///   - name: The name of the header
    ///   - value: The value of the header
    public func addHTTPHeader(name: String, value: String) {
        container.webSocketTransport.addExtraHeader(key: name, value: value)
        container.extraHeadersRequestBehavior.addHeader(key: name, value: value)
        if let httpInterceptor = container.interceptorProvider as? HttpInterceptorProvider {
            httpInterceptor.addExtraHeader(key: name, value: value)
        }
    }

    // MARK: - Internal

    private(set) var container: CoreContainer
    
    // MARK: - Private
    
    private static var _shared: NablaClient?
    
    private static func formatApiKey(_ apiKey: String) -> String {
        apiKey.replacingOccurrences(of: "Authorization: Bearer ", with: "")
    }
}
