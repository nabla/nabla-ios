import Foundation

// sourcery: AutoMockable
// sourcery: typealias = "Cancellable = NablaCore.Cancellable"
public protocol GQLClient {
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> Cancellable
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        handler: ResultHandler<Mutation.Data, GQLError>
    ) -> Cancellable
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        handler: ResultHandler<Query.Data, GQLError>
    ) -> Watcher
    
    func subscribe<Subscription: GQLSubscription>(
        subscription: Subscription,
        handler: ResultHandler<Subscription.Data, GQLError>
    ) -> Cancellable
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger])
}
