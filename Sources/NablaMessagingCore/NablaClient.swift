import Foundation
import NablaUtils

/// You should always call``NablaClient.initialize`` as soon as possible.
/// Before any interaction with messaging features make sure you
/// successfully authenticated your user by calling ``NablaClient.shared.authenticate(provider:)``.
public class NablaClient {
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
        HTTPHeaders.extra[HTTPHeaders.NablaApiKey] = formatApiKey(apiKey)
        assemble(configuration: configuration ?? DefaultConfiguration())
        _shared = NablaClient()
    }

    /// Authenticate the current user.
    /// - Parameters:
    ///   - provider: ``Tokens`` provider
    ///   - completion: Callback to get the authentication Status. See ``AuthenticationError`` for more information.
    public func authenticate(
        provider: SessionTokenProvider,
        completion: @escaping (Result<Void, AuthenticationError>) -> Void
    ) {
        authenticator.authenticate(provider: provider, completion: completion)
    }

    /// Log the current user out
    public func logOut() {
        authenticator.logOut()
    }

    /// Any ``RefetchTrigger`` will tell the SDK to update watchers with the latest server data.
    /// It is a common practice to add some ``NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)``
    /// in order to refresh the on screen information when your application comes back to foreground
    /// - Parameter triggers: The triggers to add.
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        gqlClient.addRefetchTriggers(triggers)
    }

    /// Add default HTTP Headers to calls. This is for internal usage and you should probably never call it.
    /// - Parameters:
    ///   - name: The name of the header
    ///   - value: The value of the header
    public func addHTTPHeader(name: String, value: String) {
        HTTPHeaders.extra[name] = value
    }
    
    // MARK: - Private
    
    @Inject private var authenticator: Authenticator
    @Inject private var gqlClient: GQLClient
    
    private static var _shared: NablaClient?
    
    private static func assemble(configuration: Configuration = DefaultConfiguration()) {
        let assembler = Assembler(assemblies: [
            AuthenticationAssembly(),
            DataSourceAssembly(),
            RepositoryAssembly(),
            InteractorAssembly(),
            HelperAssembly(configuration: configuration),
            NetworkAssembly(),
            GQLAssembly(),
        ])
        assembler.assemble()
    }
    
    private static func formatApiKey(_ apiKey: String) -> String {
        apiKey.replacingOccurrences(of: "Authorization: Bearer ", with: "")
    }
}
