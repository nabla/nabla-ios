import Apollo
import Foundation

// sourcery: AutoMockable
public protocol AsyncGQLStore {
    /// Throws `GQLError.CacheError`
    func createCache<Query: GQLQuery>(
        for query: Query,
        data: Query.Data
    ) async throws
    
    /// Throws `GQLError.CacheError`
    func updateCache<Query: GQLQuery>(
        for query: Query,
        onlyIfExists: Bool,
        body: @escaping (inout Query.Data) throws -> Void
    ) async throws
    
    /// Throws `GQLError.CacheError`
    func updateCache<Fragment: GQLFragment>(
        of fragment: Fragment,
        onlyIfExists: Bool,
        body: @escaping (inout Fragment) throws -> Void
    ) async throws
    
    /// Throws `GQLError.CacheError`
    func cacheExists<Query: GQLQuery>(
        for query: Query
    ) async throws -> Bool
    
    /// Throws `GQLError.CacheError`
    func cacheExists<Fragment: GQLFragment>(
        of fragment: Fragment
    ) async throws -> Bool
    
    /// Throws `GQLError.CacheError`
    func clearCache() async throws
}
