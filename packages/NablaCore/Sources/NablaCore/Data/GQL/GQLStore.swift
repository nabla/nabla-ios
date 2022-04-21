import Apollo
import Foundation

protocol GQLStore {
    var apollo: ApolloStore { get }
    
    func createCache<Q: GraphQLQuery>(
        for query: Q,
        data: Q.Data,
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
    
    func updateCache<Q: GraphQLQuery>(
        for query: Q,
        onlyIfExists: Bool,
        body: @escaping (inout Q.Data) throws -> Void,
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
    
    func updateCache<F: GraphQLFragment>(
        of fragment: F,
        onlyIfExists: Bool,
        body: @escaping (inout F) throws -> Void,
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
    
    func cacheExists<Q: GraphQLQuery>(
        for query: Q,
        completion: @escaping (Result<Bool, GQLError.CacheError>) -> Void
    )
    
    func cacheExists<F: GraphQLFragment>(
        for fragment: F,
        completion: @escaping (Result<Bool, GQLError.CacheError>) -> Void
    )
    
    func clearCache(
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
}
