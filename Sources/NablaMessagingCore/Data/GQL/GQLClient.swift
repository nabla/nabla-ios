import Foundation

protocol GQLClient {
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        completion: @escaping (Result<Query.Data, GQLError>) -> Void
    ) -> Cancellable
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        completion: @escaping (Result<Mutation.Data, GQLError>) -> Void
    ) -> Cancellable
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        callback: @escaping (Result<Query.Data, GQLError>) -> Void
    ) -> GQLWatcher<Query>
    
    func subscribe<Subscription: GQLSubscription>(
        subscription: Subscription,
        callback: @escaping (Result<Subscription.Data, GQLError>) -> Void
    ) -> Cancellable
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger])
}
