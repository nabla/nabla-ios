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
            refetchTrigers[trigger.identifier] = trigger
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
                let result = Self.parseApolloResponse(response, logger: logger)
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
                let result = Self.parseApolloResponse(response, logger: logger)
                continuation.resume(with: result)
            }
        }
    }
    
    public func watch<Query: GQLQuery>(
        query: Query,
        policy: GQLWatchPolicy
    ) -> AnyPublisher<Query.Data, GQLError> {
        let subject = CurrentValueSubject<Query.Data?, GQLError>(nil)
        
        let apolloWatcher = apollo.watch(
            query: query,
            cachePolicy: policy.apollo,
            callbackQueue: DispatchQueue.global(qos: .userInitiated),
            resultHandler: { [logger] response in
                let result = Self.parseApolloResponse(response, logger: logger)
                switch result {
                case let .failure(error):
                    subject.send(completion: .failure(error))
                case let .success(data):
                    subject.send(data)
                }
            }
        )
        
        let refetchSubscription = RefetchTrigger.refetchPublisher
            .sink { _ in
                apolloWatcher.refetch()
            }
        
        return subject
            .compactMap { $0 }
            .handleEvents(receiveCancel: {
                apolloWatcher.cancel()
                refetchSubscription.cancel()
            })
            .eraseToAnyPublisher()
    }
    
    public func subscribe<Subscription: GQLSubscription>(subscription: Subscription) -> AnyPublisher<Subscription.Data, Never> {
        let subject = PassthroughSubject<Subscription.Data, Never>()
        
        let cancellable = apollo.subscribe(
            subscription: subscription,
            queue: DispatchQueue.global(qos: .userInitiated)
        ) { [logger] response in
            let result = Self.parseApolloResponse(response, logger: logger)
            switch result {
            case let .failure(error):
                logger.warning(message: "Received subscription error", error: error)
            case let .success(data):
                subject.send(data)
            }
        }
        
        return subject
            .compactMap { $0 }
            .handleEvents(receiveCancel: cancellable.cancel)
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
    
    private var refetchTrigers = [String: RefetchTrigger]()
    
    private func makeApolloClient() -> ApolloClient {
        let apollo = ApolloClient(
            networkTransport: transport.apollo,
            store: apolloStore
        )
        apollo.cacheKeyForObject = Normalization.cacheKey(for:)
        return apollo
    }
    
    private static func parseApolloResponse<Data>(_ response: Result<GraphQLResult<Data>, Error>, logger: Logger) -> Result<Data, GQLError> {
        switch response {
        case let .failure(error):
            let parsed = parseApolloError(error, logger: logger)
            return .failure(parsed)
        case let .success(result):
            if let error = result.errors?.first {
                let parsed = parseApolloError(error, logger: logger)
                return .failure(parsed)
            }
            if let data = result.data {
                return .success(data)
            }
            return .failure(.emptyServerResponse)
        }
    }
    
    private static func parseApolloError(_ error: Error, logger: Logger) -> GQLError {
        if let graphqlError = error as? Apollo.GraphQLError {
            switch graphqlError.errorName {
            case "ENTITY_NOT_FOUND":
                return .entityNotFound(message: graphqlError.message)
            case "INTERNAL_SERVER_ERROR":
                return .serverError(message: graphqlError.message)
            case "PERMISSION_REQUIRED":
                return .permissionRequired(message: graphqlError.message)
            default:
                break
            }
            switch graphqlError.classification {
            case "ValidationError":
                return .incompatibleServerSchema(message: graphqlError.message)
            default:
                break
            }
        } else if let authenticationError = error as? AuthenticationError {
            return .authenticationError(authenticationError)
        } else if let websocketError = error as? WebSocketError {
            switch websocketError.kind {
            case .networkError, .upgradeError, .unprocessedMessage, .serializedMessageError:
                return .networkError(message: websocketError.errorDescription)
            case .errorResponse, .neitherErrorNorPayloadReceived:
                return .serverError(message: websocketError.errorDescription)
            }
        } else if let wserror = error as? WebSocket.WSError {
            return .networkError(message: wserror.message)
        } else if let responseCodeError = error as? ResponseCodeInterceptor.ResponseCodeError {
            switch responseCodeError {
            case let .invalidResponseCode(response, _):
                guard let statusCode = response?.statusCode else { return .networkError(message: responseCodeError.errorDescription) }
                switch statusCode {
                case 401: return .authenticationError(AuthorizationDeniedError(reason: responseCodeError))
                case 407, 408: return .networkError(message: responseCodeError.errorDescription)
                case 400 ..< 500: return .serverError(message: responseCodeError.errorDescription)
                case 500...: return .serverError(message: responseCodeError.errorDescription)
                default: return .unknownError
                }
            }
        } else if let sessionClientError = error as? URLSessionClient.URLSessionClientError {
            return .networkError(message: sessionClientError.errorDescription)
        }
        let nsError = error as NSError
        if nsError.domain == NSPOSIXErrorDomain {
            switch nsError.code {
            case 61: return .networkError(message: nsError.localizedDescription)
            default: break
            }
        }
        logger.warning(message: "Unhandled error type", error: error, extra: ["type": type(of: error)])
        return .unknownError
    }
}

private extension Apollo.GraphQLError {
    var errorName: String? {
        extensions?["errorName"] as? String
    }
    
    var classification: String? {
        extensions?["classification"] as? String
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
