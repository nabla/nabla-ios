import Apollo
import Combine
import Foundation
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif

class GQLClientImpl: GQLClient {
    // MARK: - Public
    
    public func addRefetchTriggers(_ triggers: [RefetchTrigger]) {
        for trigger in triggers {
            refetchTriggers[trigger.identifier] = trigger
        }
    }
    
    // MARK: GQLClient
    
    public func fetch<Query: GQLQuery>(query: Query, policy: GQLFetchPolicy) async throws -> Query.Data {
        try await withCheckedThrowingContinuation { [apollo, logger] continuation in
            apollo.fetch(
                query: query,
                cachePolicy: policy.apollo,
                queue: DispatchQueue.global(qos: .userInitiated)
            ) { response in
                let result = ApolloResponseParser.parse(response, logger: logger)
                continuation.resume(with: result)
            }
        }
    }
    
    public func perform<Mutation: GQLMutation>(mutation: Mutation) async throws -> Mutation.Data {
        try await withCheckedThrowingContinuation { [apollo, logger] continuation in
            apollo.perform(
                mutation: mutation,
                queue: DispatchQueue.global(qos: .userInitiated)
            ) { response in
                let result = ApolloResponseParser.parse(response, logger: logger)
                continuation.resume(with: result)
            }
        }
    }
    
    public func watch<Query: GQLQuery>(
        query: Query,
        policy: GQLWatchPolicy
    ) -> AnyPublisher<Query.Data, GQLError> {
        apollo.watch(query: query, cachePolicy: policy.apollo)
            .mapError { [logger] error in
                ApolloResponseParser.parse(error, logger: logger)
            }
            .nabla.resultMap { [logger] result in
                ApolloResponseParser.parse(result, logger: logger)
            }
            .eraseToAnyPublisher()
    }
    
    public func watchAndUpdate<Query: GQLQuery>(query: Query) -> AnyPublisher<AnyResponse<Query.Data, GQLError>, GQLError> {
        apollo.watchAndUpdate(query: query)
            .mapError { [logger] error in
                ApolloResponseParser.parse(error, logger: logger)
            }
            .map { [logger] response in
                response.mapError { error in
                    ApolloResponseParser.parse(error, logger: logger)
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func subscribe<Subscription: GQLSubscription>(subscription: Subscription) -> AnyPublisher<Subscription.Data, Never> {
        apollo.subscribe(subscription: subscription)
            .mapError { [logger] error in
                ApolloResponseParser.parse(error, logger: logger)
            }
            .nabla.resultMap { [logger] result in
                ApolloResponseParser.parse(result, logger: logger)
            }
            .retry(Int.max) // Infinitely retry subscription errors
            .catch { [logger] error in
                logger.error(message: "Received terminating subscription error", error: error)
                return Empty<Subscription.Data, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Internal
    
    // MARK: Initializer
    
    init(
        transport: CombinedTransport,
        apolloStore: ApolloStore,
        logger: Logger
    ) {
        self.transport = transport
        self.apolloStore = apolloStore
        self.logger = logger
    }
    
    // MARK: - Private
    
    private let transport: CombinedTransport
    private let apolloStore: ApolloStore
    private var logger: Logger
    
    private lazy var apollo: ApolloClient = makeApolloClient()
    
    private var refetchTriggers = [String: RefetchTrigger]()
    
    private func makeApolloClient() -> ApolloClient {
        let apollo = ApolloClient(
            networkTransport: transport.apollo,
            store: apolloStore
        )
        apollo.cacheKeyForObject = Normalization.cacheKey(for:)
        return apollo
    }
}

private extension GQLFetchPolicy {
    var apollo: CachePolicy {
        switch self {
        case .returnCacheDataElseFetch: return .returnCacheDataElseFetch
        case .fetchIgnoringCacheData: return .fetchIgnoringCacheData
        case .fetchIgnoringCacheCompletely: return .fetchIgnoringCacheCompletely
        case .returnCacheDataDontFetch: return .returnCacheDataDontFetch
        }
    }
}

private extension GQLWatchPolicy {
    var apollo: CachePolicy {
        switch self {
        case .returnCacheDataElseFetch: return .returnCacheDataElseFetch
        case .fetchIgnoringCacheData: return .fetchIgnoringCacheData
        case .returnCacheDataDontFetch: return .returnCacheDataDontFetch
        case .returnCacheDataAndFetch: return .returnCacheDataAndFetch
        }
    }
}
