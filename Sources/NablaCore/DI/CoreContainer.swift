import Apollo
import Foundation

public class CoreContainer {
    // MARK: - Public
    
    public var logger: Logger {
        configuration.logger
    }
    
    public private(set) lazy var logOutInteractor: LogOutInteractor = LogOutInteractorImpl(
        userRepository: userRepository,
        authenticator: authenticator,
        gqlStore: gqlStore,
        keyValueStore: keyValueStore,
        logger: logger
    )
    
    public private(set) lazy var environment: Environment = EnvironmentImpl(networkConfiguration: networkConfiguration)
    
    public private(set) lazy var extraHeaders: ExtraHeaders = ExtraHeadersImpl([
        HTTPHeaders.Platform: environment.platform,
        HTTPHeaders.Version: environment.version,
        HTTPHeaders.AcceptLanguage: environment.languageCode,
    ])

    public private(set) lazy var authenticator: Authenticator = AuthenticatorImpl(httpManager: httpManager)

    public private(set) lazy var userRepository: UserRepository = UserRepositoryImpl(localDataSource: userLocalDataSource)

    public private(set) lazy var httpManager: HTTPManager = .init(
        baseURLProvider: URLProvider(
            baseURL: environment.serverUrl
        ),
        session: networkConfiguration.session,
        requestBehavior: headersRequestBehavior
    )
    
    public private(set) lazy var uploadClient: UploadClient = .init(
        httpManager: httpManager,
        authenticator: authenticator
    )
    
    public private(set) lazy var gqlClient: GQLClient & AsyncGQLClient = {
        let client = GQLClientImpl(
            transport: combinedTransport,
            store: gqlStore,
            apolloStore: apolloStore,
            logger: logger
        )
        client.addRefetchTriggers([reachabilityRefetchTrigger])
        return client
    }()

    public private(set) lazy var gqlStore: GQLStore & AsyncGQLStore = GQLStoreImpl(apolloStore: apolloStore)
    
    public let modules: [Module]
    
    public private(set) lazy var messagingClient: MessagingClient? = messagingModule?.makeClient(container: self)
    
    public private(set) lazy var videoCallClient: VideoCallClient? = videoCallModule?.makeClient(container: self)
    
    public private(set) lazy var schedulingClient: SchedulingClient? = schedulingModule?.makeClient(container: self)

    public private(set) lazy var errorReporter: ErrorReporter = configuration.enableReporting
        ? SentryErrorReporter(logger: logger)
        : NoOpErrorReporter()
    
    // MARK: - Internal
    
    private(set) lazy var headersRequestBehavior = HeadersRequestBehavior(headers: extraHeaders)
    
    private(set) lazy var registerDeviceInteractor: RegisterDeviceInteractor = RegisterDeviceInteractorImpl(
        modules: modules,
        deviceRepository: deviceRepository
    )
    
    // Mutable for mocking purposes
    lazy var urlSessionClient: URLSessionClient = .init()
    
    // Mutable for mocking purposes
    lazy var deviceLocalDataSource: DeviceLocalDataSource = DeviceLocalDataSourceImpl(
        store: keyValueStore,
        logger: logger
    )

    init(
        name: String,
        configuration: Configuration,
        networkConfiguration: NetworkConfiguration,
        modules: [Module]
    ) {
        self.name = name
        self.networkConfiguration = networkConfiguration
        self.configuration = configuration
        self.modules = modules
        messagingModule = modules.first(as: MessagingModule.self)
        videoCallModule = modules.first(as: VideoCallModule.self)
        schedulingModule = modules.first(as: SchedulingModule.self)
    }

    // MARK: - Private

    private let name: String
    private let configuration: Configuration
    private let networkConfiguration: NetworkConfiguration
    private let messagingModule: MessagingModule?
    private let videoCallModule: VideoCallModule?
    private let schedulingModule: SchedulingModule?

    private lazy var reachabilityRefetchTrigger: ReachabilityRefetchTrigger = .init(environment: environment)

    private lazy var interceptorProvider: InterceptorProvider = HttpInterceptorProvider(
        environment: environment,
        authenticator: authenticator,
        extraHeaders: extraHeaders,
        apolloStore: apolloStore,
        urlSessionClient: urlSessionClient
    )

    private lazy var httpTransport: HttpTransport = .init(
        environment: environment,
        interceptorProvider: interceptorProvider
    )
    
    private lazy var webSocketTransport: WebSocketTransport = .init(
        environment: environment,
        store: gqlStore,
        authenticator: authenticator,
        apolloStore: apolloStore,
        logger: logger,
        extraHeaders: extraHeaders
    )
    
    private lazy var combinedTransport: CombinedTransport = .init(
        httpTransport: httpTransport,
        webSocketTransport: webSocketTransport
    )
    
    private lazy var apolloStore: ApolloStore = .init()

    private lazy var userLocalDataSource: UserLocalDataSource = UserLocalDataSourceImpl(
        logger: logger,
        store: keyValueStore
    )

    private lazy var keyValueStore: KeyValueStore = KeyValueStoreImpl(namespace: name)
    
    private lazy var deviceRemoteDataSource: DeviceRemoteDataSource = DeviceRemoteDataSourceImpl(gqlClient: gqlClient)
    
    private lazy var deviceRepository: DeviceRepository = DeviceRepositoryImpl(
        deviceLocalDataSource: deviceLocalDataSource,
        deviceRemoteDataSource: deviceRemoteDataSource,
        logger: logger,
        errorReporter: errorReporter
    )
}

private struct URLProvider: BaseURLProvider {
    let baseURL: URL
}

private extension Array {
    func first<T>(as _: T.Type) -> T? {
        first(where: { $0 is T }) as? T
    }
}
