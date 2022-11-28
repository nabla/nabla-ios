import Foundation

// sourcery: AutoMockable
public protocol GQLClient {
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> NablaCancellable
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        handler: ResultHandler<Mutation.Data, GQLError>
    ) -> NablaCancellable
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> Watcher
    
    func subscribe<Subscription: GQLSubscription>(
        subscription: Subscription,
        handler: ResultHandler<Subscription.Data, GQLError>
    ) -> NablaCancellable
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger])
}
