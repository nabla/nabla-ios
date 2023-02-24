import Apollo
import Foundation

// sourcery: AutoMockable
public protocol GQLStore {
    /// - Throws: ``GQLError/CacheError``
    func updateCache<CacheMutation: LocalCacheMutation>(
        cacheMutation: CacheMutation,
        body: @escaping (inout CacheMutation.Data) throws -> Void
    ) async throws
    
    /// - Throws: ``GQLError/CacheError``
    func clearCache() async throws
}
