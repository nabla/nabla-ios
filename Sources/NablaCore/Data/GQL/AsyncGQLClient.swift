import Combine
import Foundation

public enum GQLFetchPolicy {
    /// Return data from the cache if available, else fetch results from the server.
    case returnCacheDataElseFetch
    ///  Always fetch results from the server.
    case fetchIgnoringCacheData
    ///  Always fetch results from the server, and don't store these in the cache.
    case fetchIgnoringCacheCompletely
    /// Return data from the cache if available, else return nil.
    case returnCacheDataDontFetch
}

public protocol AsyncGQLClient {
    /// Throws `GQLError`
    func fetch<Query: GQLQuery>(query: Query, cachePolicy: GQLFetchPolicy) async throws -> Query.Data
    
    /// Throws `GQLError`
    func perform<Mutation: GQLMutation>(mutation: Mutation) async throws -> Mutation.Data
    
    func watch<Query: GQLQuery>(query: Query) -> AnyPublisher<Query.Data, GQLError>
    
    func subscribe<Subscription: GQLSubscription>(subscription: Subscription) -> AnyPublisher<Subscription.Data, GQLError>
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger])
}
