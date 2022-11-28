import Apollo
import Foundation

// sourcery: AutoMockable
public protocol GQLStore {
    func createCache<Query: GQLQuery>(
        for query: Query,
        data: Query.Data,
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
    
    func updateCache<Query: GQLQuery>(
        for query: Query,
        onlyIfExists: Bool,
        body: @escaping (inout Query.Data) throws -> Void,
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
    
    func updateCache<Fragment: GQLFragment>(
        of fragment: Fragment,
        onlyIfExists: Bool,
        body: @escaping (inout Fragment) throws -> Void,
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
    
    func cacheExists<Query: GQLQuery>(
        for query: Query,
        completion: @escaping (Result<Bool, GQLError.CacheError>) -> Void
    )
    
    func cacheExists<Fragment: GQLFragment>(
        of fragment: Fragment,
        completion: @escaping (Result<Bool, GQLError.CacheError>) -> Void
    )
    
    func clearCache(
        completion: @escaping (Result<Void, GQLError.CacheError>) -> Void
    )
}
