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
    ///   - logger: Instance receiving all logs emitted by the SDK. Defaults to `ConsoleLogger` based on `os_log`.
    ///   - networkConfiguration: optional network configuration, exposed for internal tests purposes and should not be used in your app
    public convenience init(
        apiKey: String,
        name: String,
        logger: Logger = ConsoleLogger(),
        networkConfiguration: NetworkConfiguration? = nil,
        modules: [Module]
    ) {
        let configuration = networkConfiguration ?? DefaultNetworkConfiguration()
        let container = CoreContainer(
            name: name,
            networkConfiguration: configuration,
            logger: logger,
            modules: modules
        )
        self.init(apiKey: apiKey, container: container)
    }
    
    /// Internal use only
    init(apiKey: String, container: CoreContainer) {
        self.container = container
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
    ///   - logger: Instance receiving all logs emitted by the SDK. Defaults to `ConsoleLogger` based on `os_log`.
    ///   - networkConfiguration: optional network configuration, exposed for internal tests purposes and should not be used in your app
    public static func initialize(
        apiKey: String,
        logger: Logger = ConsoleLogger(),
        networkConfiguration: NetworkConfiguration? = nil,
        modules: [Module]
    ) {
        guard _shared == nil else {
            logger.warning(message: "NablaClient.initialize(configuration:) should only be called once. Ignoring this call and using the previously created shared instance.")
            return
        }
        _shared = NablaClient(
            apiKey: apiKey,
            name: Constants.defaultName,
            logger: logger,
            networkConfiguration: networkConfiguration,
            modules: modules
        )
    }

    /// Authenticate the current user.
    /// - Parameters:
    ///   - userId: Identifies the user between sessions, will be passed when calling the ``SessionTokenProvider``.
    ///   - provider: ``Tokens`` provider
    public func authenticate(
        userId: String,
        provider: SessionTokenProvider
    ) {
        if let currentUser = container.userRepository.getCurrentUser(), currentUser.id != userId {
            container.logger.info(message: "Authenticating a new user, will log previous one out first.")
            logOut()
        }
        container.userRepository.setCurrentUser(User(id: userId))
        container.authenticator.authenticate(userId: userId, provider: provider)
        
        registerDeviceAction = container.registerDeviceInteractor.execute()
    }

    /// Log the current user out
    public func logOut() {
        container.logOutInteractor.execute()
    }

    /// Add default HTTP Headers to calls. This is for internal usage and you should probably never call it.
    /// - Parameters:
    ///   - name: The name of the header
    ///   - value: The value of the header
    public func addHTTPHeader(name: String, value: String) {
        container.extraHeaders.set(value, for: name)
    }
    
    /// Any ``RefetchTrigger`` will tell the SDK to update watchers with the latest server data.
    /// It is a common practice to add some ``NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)``
    /// in order to refresh the on screen information when your application comes back to foreground
    /// - Parameter triggers: The triggers to add.
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        container.gqlClient.addRefetchTriggers(triggers)
    }
    
    /// Internal use only.
    public private(set) var container: CoreContainer

    // MARK: - Private
    
    private static var _shared: NablaClient?
    
    private static func formatApiKey(_ apiKey: String) -> String {
        apiKey.replacingOccurrences(of: "Authorization: Bearer ", with: "")
    }
    
    private var registerDeviceAction: Cancellable?
}
