import Apollo
import Foundation
#if canImport(ApolloSQLite)
    import ApolloSQLite
#endif

public class CoreContainer {
    // MARK: - Public
    
    public let logger: Logger
    public let logOutInteractor: LogOutInteractor
    public let environment: Environment
    public let extraHeaders: ExtraHeaders
    public let authenticator: Authenticator
    public let userRepository: UserRepository
    public let httpManager: HTTPManager
    public let uploadClient: UploadClient
    public let gqlClient: GQLClient
    public let gqlStore: GQLStore
    public let modules: [Module]
    public private(set) var messagingClient: MessagingClient?
    public private(set) var videoCallClient: VideoCallClient?
    public private(set) var schedulingClient: SchedulingClient?
    public let errorReporter: ErrorReporter
    public let uuidGenerator: UUIDGenerator
    
    // MARK: - Internal
    
    let webSocketTransport: WebSocketTransport
    let initializeInteractor: InitializeInteractor
    let setCurrentUserInteractor: SetCurrentUserInteractor
    
    convenience init(
        name: String,
        configuration: Configuration,
        modules: [Module],
        sessionTokenProvider: SessionTokenProvider
    ) {
        self.init(
            name: name,
            configuration: configuration,
            urlSessionClient: .init(),
            deviceLocalDataSource: nil,
            uuidGenerator: FoundationUUIDGenerator(),
            modules: modules,
            sessionTokenProvider: sessionTokenProvider
        )
    }

    // For mocking purposes, prefer the `convenience init` instead
    init(
        name: String,
        configuration: Configuration,
        urlSessionClient: URLSessionClient,
        deviceLocalDataSource: DeviceLocalDataSource?,
        uuidGenerator: UUIDGenerator,
        modules: [Module],
        sessionTokenProvider: SessionTokenProvider
    ) {
        self.name = name
        self.configuration = configuration
        self.modules = modules
        self.uuidGenerator = uuidGenerator
        
        environment = EnvironmentImpl(networkConfiguration: configuration.network)

        let compositeLogger = MutableCompositeLogger(configuration.logger)
        logger = compositeLogger
        errorReporter = configuration.enableReporting
            ? SentryErrorReporter(logger: logger)
            : NoOpErrorReporter()
        
        scopedKeyValueStore = KeyValueStoreImpl(namespace: name)
        dangerouslyUnscopedKeyValueStore = KeyValueStoreImpl(namespace: "nablaGlobal")
        
        self.deviceLocalDataSource = deviceLocalDataSource ?? DeviceLocalDataSourceImpl(
            scopedStore: scopedKeyValueStore,
            unscopedStore: dangerouslyUnscopedKeyValueStore,
            logger: logger
        )
        
        compositeLogger.addLogger(logger: ErrorReporterLogger(
            errorReporter: errorReporter,
            publicApiKey: configuration.apiKey,
            sdkVersion: environment.version,
            deviceName: self.deviceLocalDataSource.deviceModel,
            OSVersion: self.deviceLocalDataSource.deviceOSVersion
        ))
        
        extraHeaders = ExtraHeadersImpl([
            HTTPHeaders.Platform: environment.platform,
            HTTPHeaders.Version: environment.version,
            HTTPHeaders.AcceptLanguage: environment.languageCode,
        ])
        headersRequestBehavior = HeadersRequestBehavior(headers: extraHeaders)
        
        httpManager = .init(
            baseURLProvider: URLProvider(
                baseURL: environment.serverUrl
            ),
            session: configuration.network.session,
            requestBehavior: headersRequestBehavior
        )
        authenticator = AuthenticatorImpl(
            httpManager: httpManager,
            sessionTokenProvider: sessionTokenProvider
        )
        apolloStore = Self.makeApolloStore(logger: logger)
        interceptorProvider = HttpInterceptorProvider(
            environment: environment,
            authenticator: authenticator,
            extraHeaders: extraHeaders,
            apolloStore: apolloStore,
            urlSessionClient: urlSessionClient
        )
        httpTransport = .init(
            environment: environment,
            interceptorProvider: interceptorProvider
        )
        webSocketTransport = .init(
            environment: environment,
            authenticator: authenticator,
            apolloStore: apolloStore,
            logger: logger,
            extraHeaders: extraHeaders
        )
        combinedTransport = .init(
            httpTransport: httpTransport,
            webSocketTransport: webSocketTransport
        )
        uploadClient = .init(
            httpManager: httpManager,
            authenticator: authenticator
        )
        gqlClient = GQLClientImpl(
            transport: combinedTransport,
            apolloStore: apolloStore,
            logger: logger
        )
        gqlClient.addRefetchTriggers([ReachabilityRefetchTrigger(environment: environment)])
        gqlStore = GQLStoreImpl(apolloStore: apolloStore)
        
        userLocalDataSource = UserLocalDataSourceImpl(
            logger: logger,
            store: scopedKeyValueStore
        )
        
        deviceRemoteDataSource = DeviceRemoteDataSourceImpl(gqlClient: gqlClient)
        deviceRepository = DeviceRepositoryImpl(
            deviceLocalDataSource: self.deviceLocalDataSource,
            deviceRemoteDataSource: deviceRemoteDataSource,
            logger: logger
        )
        
        userRepository = UserRepositoryImpl(localDataSource: userLocalDataSource)
        
        logOutInteractor = LogOutInteractorImpl(
            userRepository: userRepository,
            authenticator: authenticator,
            gqlStore: gqlStore,
            scopedKeyValueStore: scopedKeyValueStore,
            logger: logger,
            errorReporter: errorReporter
        )
        initializeInteractor = InitializeInteractorImpl(
            deviceRepository: deviceRepository,
            errorReporter: errorReporter,
            environment: environment,
            extraHeaders: extraHeaders
        )
        setCurrentUserInteractor = SetCurrentUserInteractorImpl(
            environment: environment,
            authenticator: authenticator,
            userRepository: userRepository,
            deviceRepository: deviceRepository,
            errorReport: errorReporter,
            logger: logger,
            modules: modules
        )
        
        messagingModule = modules.first(as: MessagingModule.self)
        videoCallModule = modules.first(as: VideoCallModule.self)
        schedulingModule = modules.first(as: SchedulingModule.self)
        messagingClient = messagingModule?.makeClient(container: self)
        videoCallClient = videoCallModule?.makeClient(container: self)
        schedulingClient = schedulingModule?.makeClient(container: self)
    }

    // MARK: - Private

    private let name: String
    private let configuration: Configuration
    private let headersRequestBehavior: HeadersRequestBehavior
    private let messagingModule: MessagingModule?
    private let videoCallModule: VideoCallModule?
    private let schedulingModule: SchedulingModule?
    private let interceptorProvider: InterceptorProvider
    private let httpTransport: HttpTransport
    private let combinedTransport: CombinedTransport
    private let apolloStore: ApolloStore
    private let userLocalDataSource: UserLocalDataSource
    private let scopedKeyValueStore: KeyValueStore
    /// This one is not scoped to the Nabla SDK instance meaning it will be shared across multiple instances of the SDK.
    /// You probably don't want to use it unless you have a very good reason to do so.
    private let dangerouslyUnscopedKeyValueStore: KeyValueStore
    private let deviceRemoteDataSource: DeviceRemoteDataSource
    private let deviceLocalDataSource: DeviceLocalDataSource
    private let deviceRepository: DeviceRepository
    
    private static func makeApolloStore(logger: Logger) -> ApolloStore {
        if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsURL = URL(fileURLWithPath: documentsPath)
            let sqliteFileURL = documentsURL.appendingPathComponent("nabla_apollo.sqlite")
            if let sqliteCache = try? SQLiteNormalizedCache(fileURL: sqliteFileURL) {
                return .init(cache: sqliteCache)
            } else {
                logger.error(message: "Error initializing SQLite cache, cache will be in memory only and won't be persisted.")
            }
        }
        return .init()
    }
}

private struct URLProvider: BaseURLProvider {
    let baseURL: URL
}

private extension Array {
    func first<T>(as _: T.Type) -> T? {
        first(where: { $0 is T }) as? T
    }
}
