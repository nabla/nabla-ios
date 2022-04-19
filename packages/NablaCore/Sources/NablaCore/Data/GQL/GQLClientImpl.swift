import Apollo
import Foundation
import NablaUtils

class GQLClientImpl: GQLClient {
    // MARK: - Internal
    
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        completion: @escaping (Result<Query.Data, GQLError>) -> Void
    ) -> Cancellable {
        apollo.fetch(query: query, cachePolicy: cachePolicy) { response in
            let result = Self.parseApolloResponse(response)
            completion(result)
        }
        .toNablaCancellable()
    }
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        completion: @escaping (Result<Mutation.Data, GQLError>) -> Void
    ) -> Cancellable {
        apollo.perform(mutation: mutation) { response in
            let result = Self.parseApolloResponse(response)
            completion(result)
        }
        .toNablaCancellable()
    }
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        callback: @escaping (Result<Query.Data, GQLError>) -> Void
    ) -> GQLWatcher<Query> {
        let apolloWatcher = apollo.watch(query: query, cachePolicy: cachePolicy) { response in
            let result = Self.parseApolloResponse(response)
            callback(result)
        }
        // TODO: @tgy configure server url
        return GQLWatcher(apolloWatcher)
    }
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger]) {
        refetchTrrigers.append(contentsOf: triggers)
    }
    
    // MARK: - Private
    
    @Inject private var transport: CombinedTransport
    @Inject private var store: GQLStore
    
    private lazy var apollo: ApolloClient = makeApolloClient()
    
    private var refetchTrrigers = [RefetchTrigger]()
    
    private func makeApolloClient() -> ApolloClient {
        ApolloClient(
            networkTransport: transport.apollo,
            store: store.apollo
        )
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
    
    private static func parseApolloError(_: Error) -> GQLError {
        // TODO: @tgy Handle each Apollo errors individually
        .emptyServerResponse
    }
}
