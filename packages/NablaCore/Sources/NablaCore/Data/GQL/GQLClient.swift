import Foundation

protocol GQLClient {
    func fetch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        completion: @escaping (Result<Query.Data, GQLError>) -> Void
    )
    
    func perform<Mutation: GQLMutation>(
        mutation: Mutation,
        completion: @escaping (Result<Mutation.Data, GQLError>) -> Void
    )
    
    func watch<Query: GQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        completion: @escaping (Result<Query.Data, GQLError>) -> Void
    ) -> GQLWatcher<Query>
    
    func addRefetchTriggers(_ triggers: [RefetchTrigger])
}
