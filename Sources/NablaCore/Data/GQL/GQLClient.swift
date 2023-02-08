import Combine
import Foundation

// sourcery: AutoMockable
public protocol GQLClient {
    /// - Throws: ``GQLError``
    func fetch<Query: GQLQuery>(query: Query, policy: GQLFetchPolicy) async throws -> Query.Data
    
    /// - Throws: ``GQLError``
    func perform<Mutation: GQLMutation>(mutation: Mutation) async throws -> Mutation.Data
    
    func watch<Query: GQLQuery>(query: Query, policy: GQLWatchPolicy) -> AnyPublisher<Query.Data, GQLError>
    
    func watchAndUpdate<Query: GQLQuery>(query: Query) -> AnyPublisher<AnyResponse<Query.Data, GQLError>, GQLError>
    
    func subscribe<Subscription: GQLSubscription>(subscription: Subscription) -> AnyPublisher<Subscription.Data, Never>
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger])
}
