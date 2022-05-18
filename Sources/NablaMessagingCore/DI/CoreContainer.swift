import Apollo
import Foundation

class CoreContainer {
    init(name: String,
         configuration: Configuration) {
        self.name = name
        self.configuration = configuration
    }

    // MARK: - Public

    private(set) lazy var authenticator: Authenticator = AuthenticatorImpl(httpManager: httpManager)

    private(set) lazy var gqlClient: GQLClient = {
        let client = GQLClientImpl(transport: combinedTransport, store: gqlStore, apolloStore: apolloStore, logger: logger)
        client.addRefetchTriggers([reachabilityRefetchTrigger])
        return client
    }()

    private(set) lazy var gqlStore: GQLStore = GQLStoreImpl(apolloStore: apolloStore)

    private(set) lazy var userRepository: UserRepository = UserRepositoryImpl(localDataSource: userLocalDataSource)

    private(set) lazy var httpManager: HTTPManager = .init(
        baseURLProvider: URLProvider(
            baseURL: environment.serverUrl
        ),
        requestBehavior: extraHeadersRequestBehavior
    )

    private(set) lazy var webSocketTransport: WebSocketTransport = .init(
        environment: environment,
        store: gqlStore,
        authenticator: authenticator,
        apolloStore: apolloStore,
        logger: logger
    )

    private(set) lazy var interceptorProvider: InterceptorProvider = HttpInterceptorProvider(
        httpManager: httpManager,
        authenticator: authenticator,
        apolloStore: apolloStore
    )

    private(set) lazy var logger: Logger = ConsoleLogger()

    private(set) lazy var extraHeadersRequestBehavior = AddExtraHeadersRequestBehavior(headers: [:])

    // MARK: - Private

    private let name: String
    private let configuration: Configuration

    private lazy var environment: Environment = EnvironmentImpl(configuration: configuration)

    private lazy var combinedTransport: CombinedTransport = .init(
        httpTransport: httpTransport,
        webSocketTransport: webSocketTransport
    )

    private lazy var httpTransport: HttpTransport = .init(
        environment: environment,
        interceptorProvider: interceptorProvider
    )

    private lazy var reachabilityRefetchTrigger: ReachabilityRefetchTrigger = .init(environment: environment)

    private lazy var userLocalDataSource: UserLocalDataSource = UserLocalDataSourceImpl(
        logger: logger,
        store: keyValueStore
    )

    private lazy var keyValueStore: KeyValueStore = KeyValueStoreImpl(namespace: name)

    private lazy var apolloStore: ApolloStore = .init()
}

private struct URLProvider: BaseURLProvider {
    let baseURL: URL
}
