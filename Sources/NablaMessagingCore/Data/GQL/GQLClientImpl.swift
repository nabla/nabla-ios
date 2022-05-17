import Apollo
import Foundation
import NablaUtils

class GQLClientImpl: GQLClient {
    // MARK: - Internal
    
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> Cancellable {
        apollo.fetch(query: query, cachePolicy: cachePolicy) { response in
            let result = Self.parseApolloResponse(response)
            handler(result)
        }
        .toNablaCancellable()
    }
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        handler: ResultHandler<Mutation.Data, GQLError>
    ) -> Cancellable {
        apollo.perform(mutation: mutation) { response in
            let result = Self.parseApolloResponse(response)
            handler(result)
        }
        .toNablaCancellable()
    }
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> GQLWatcher<Query> {
        let apolloWatcher = apollo.watch(query: query, cachePolicy: cachePolicy) { response in
            let result = Self.parseApolloResponse(response)
            handler(result)
        }
        // TODO: @tgy configure server url
        return GQLWatcher(apolloWatcher)
    }
    
    func subscribe<Subscription: GQLSubscription>(
        subscription: Subscription,
        handler: ResultHandler<Subscription.Data, GQLError>
    ) -> Cancellable {
        apollo.subscribe(subscription: subscription) { response in
            let result = Self.parseApolloResponse(response)
            handler(result)
        }
        .toNablaCancellable()
    }
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger]) {
        refetchTrigers.append(contentsOf: triggers)
    }
    
    // MARK: - Private
    
    @Inject private var transport: CombinedTransport
    @Inject private var store: GQLStore
    @Inject private var apolloStore: ApolloStore
    
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
    
    private static func parseApolloResponse<Data>(_ response: Result<GraphQLResult<Data>, Error>) -> Result<Data, GQLError> {
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
    
    private static func parseApolloError(_ error: Error) -> GQLError {
        if let graphqlError = error as? Apollo.GraphQLError {
            switch graphqlError.errorName {
            case "ENTITY_NOT_FOUND":
                let path = graphqlError["path"] as? [String] ?? []
                return .entityNotFound(path: path)
            case "INTERNAL_SERVER_ERROR":
                return .internalServerError(message: graphqlError.message)
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
        }
        
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
