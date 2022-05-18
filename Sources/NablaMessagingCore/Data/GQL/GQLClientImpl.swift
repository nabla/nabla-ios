import Apollo
import ApolloWebSocket
import Foundation
import NablaUtils

class GQLClientImpl: GQLClient {
    // MARK: - Initializer

    init(
        transport: CombinedTransport,
        store: GQLStore,
        apolloStore: ApolloStore,
        logger: Logger
    ) {
        self.transport = transport
        self.store = store
        self.apolloStore = apolloStore
        self.logger = logger
    }

    // MARK: - Internal
    
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> Cancellable {
        apollo.fetch(query: query, cachePolicy: cachePolicy) { [weak self] response in
            guard let self = self else { return handler(.failure(.internalError)) }
            let result = self.parseApolloResponse(response)
            handler(result)
        }
        .toNablaCancellable()
    }
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        handler: ResultHandler<Mutation.Data, GQLError>
    ) -> Cancellable {
        apollo.perform(mutation: mutation) { [weak self] response in
            guard let self = self else { return handler(.failure(.internalError)) }
            let result = self.parseApolloResponse(response)
            handler(result)
        }
        .toNablaCancellable()
    }
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> GQLWatcher<Query> {
        let apolloWatcher = apollo.watch(query: query, cachePolicy: cachePolicy) { [weak self] response in
            guard let self = self else { return handler(.failure(.internalError)) }
            let result = self.parseApolloResponse(response)
            handler(result)
        }
        return GQLWatcher(apolloWatcher)
    }
    
    func subscribe<Subscription: GQLSubscription>(
        subscription: Subscription,
        handler: ResultHandler<Subscription.Data, GQLError>
    ) -> Cancellable {
        apollo.subscribe(subscription: subscription) { [weak self] response in
            guard let self = self else { return handler(.failure(.internalError)) }
            let result = self.parseApolloResponse(response)
            handler(result)
        }
        .toNablaCancellable()
    }
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger]) {
        refetchTrigers.append(contentsOf: triggers)
    }
    
    // MARK: - Private

    private let transport: CombinedTransport
    private let store: GQLStore
    private let apolloStore: ApolloStore
    private var logger: Logger
    
    private lazy var apollo: ApolloClient = makeApolloClient()
    
    private var refetchTrigers = [RefetchTrigger]()
    
    private func makeApolloClient() -> ApolloClient {
        let apollo = ApolloClient(
            networkTransport: transport.apollo,
            store: apolloStore
        )
        apollo.cacheKeyForObject = Normalization.cacheKey(for:)
        return apollo
    }
    
    private func parseApolloResponse<Data>(_ response: Result<GraphQLResult<Data>, Error>) -> Result<Data, GQLError> {
        switch response {
        case let .failure(error):
            let parsed = parseApolloError(error)
            return .failure(parsed)
        case let .success(result):
            if let error = result.errors?.first {
                let parsed = parseApolloError(error)
                return .failure(parsed)
            }
            if let data = result.data {
                return .success(data)
            }
            return .failure(.emptyServerResponse)
        }
    }
    
    private func parseApolloError(_ error: Error) -> GQLError {
        if let graphqlError = error as? Apollo.GraphQLError {
            switch graphqlError.errorName {
            case "ENTITY_NOT_FOUND":
                let path = graphqlError["path"] as? [String] ?? []
                return .entityNotFound(path: path)
            case "INTERNAL_SERVER_ERROR":
                return .serverError(message: graphqlError.message)
            default:
                break
            }
            switch graphqlError.classification {
            case "ValidationError":
                return .incompatibleServerSchema(message: graphqlError.message)
            default:
                break
            }
        } else if let authenticationError = error as? NablaAuthenticationError {
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
                case 400 ..< 500: return .networkError(message: responseCodeError.errorDescription)
                case 500...: return .serverError(message: responseCodeError.errorDescription)
                default: return .unknownError
                }
            }
        }
        logger.warning(message: "Unhandled error type: \(type(of: error)). Description: \(String(describing: error))")
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
