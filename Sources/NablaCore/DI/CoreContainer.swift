import Apollo
import Foundation

public class CoreContainer {
    // MARK: - Public
    
    public let logger: Logger
    
    public private(set) lazy var logOutInteractor: LogOutInteractor = LogOutInteractorImpl(
        userRepository: userRepository,
        authenticator: authenticator,
        gqlStore: gqlStore,
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
    
    public private(set) lazy var gqlClient: GQLClient = {
        let client = GQLClientImpl(
            transport: combinedTransport,
            store: gqlStore,
            apolloStore: apolloStore,
            logger: logger
        )
        client.addRefetchTriggers([reachabilityRefetchTrigger])
        return client
    }()

    public private(set) lazy var gqlStore: GQLStore = GQLStoreImpl(apolloStore: apolloStore)
    
    // MARK: - Internal
    
    private(set) lazy var headersRequestBehavior = HeadersRequestBehavior(headers: extraHeaders)
    
    // Mutable for mocking purposes
    lazy var urlSessionClient: URLSessionClient = .init()
    
    init(
        name: String,
        networkConfiguration: NetworkConfiguration,
        logger: Logger
    ) {
        self.name = name
        self.networkConfiguration = networkConfiguration
        self.logger = logger
    }

    // MARK: - Private

    private let name: String
    private let networkConfiguration: NetworkConfiguration
    
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
}

private struct URLProvider: BaseURLProvider {
    let baseURL: URL
}
