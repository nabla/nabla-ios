import Apollo
import Foundation

class GQLStoreImpl: GQLStore {
    // MARK: - Public
    
    // MARK: GQLStore
    
    func createCache<Query: GQLQuery>(for query: Query, data: Query.Data) async throws {
        try await withCheckedThrowingContinuation { continuation in
            apollo.withinReadWriteTransaction(
                _: { transaction in
                    try transaction.write(data: data, forQuery: query)
                },
                completion: Self.makeCompletionHandler(continuation: continuation)
            )
        }
    }
    
    func updateCache<Query: GQLQuery>(
        for query: Query,
        onlyIfExists: Bool,
        body: @escaping (inout Query.Data) throws -> Void
    ) async throws {
        try await withCheckedThrowingContinuation { continuation in
            apollo.withinReadWriteTransaction(
                _: { transaction in
                    let cache = try? transaction.read(query: query)
                    if cache != nil {
                        try transaction.update(query: query, body)
                    } else if onlyIfExists {
                        return // If the cache does not exist, silently return
                    } else {
                        throw GQLError.cacheError(.queryNotCached)
                    }
                },
                completion: Self.makeCompletionHandler(continuation: continuation)
            )
        }
    }
    
    func updateCache<Fragment: GQLFragment>(
        of fragment: Fragment,
        onlyIfExists: Bool,
        body: @escaping (inout Fragment) throws -> Void
    ) async throws {
        guard let key = Normalization.cacheKey(for: fragment.jsonObject) else {
            throw GQLError.CacheError.normalizationFailed(object: fragment)
        }
        
        try await withCheckedThrowingContinuation { continuation in
            apollo.withinReadWriteTransaction(
                _: { transaction in
                    let cache = try? transaction.readObject(ofType: Fragment.self, withKey: key)
                    if cache != nil {
                        try transaction.updateObject(ofType: Fragment.self, withKey: key, body)
                    } else if onlyIfExists {
                        return // If the cache does not exist, silently return
                    } else {
                        throw GQLError.cacheError(.entityNotCached)
                    }
                },
                completion: Self.makeCompletionHandler(continuation: continuation)
            )
        }
    }
    
    func cacheExists<Query: GQLQuery>(for query: Query) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            apollo.withinReadWriteTransaction(
                _: { transaction -> Bool in
                    let cache = try? transaction.read(query: query)
                    return cache != nil
                },
                completion: Self.makeCompletionHandler(continuation: continuation)
            )
        }
    }
    
    func cacheExists<Fragment: GQLFragment>(of fragment: Fragment) async throws -> Bool {
        guard let key = Normalization.cacheKey(for: fragment.jsonObject) else {
            throw GQLError.CacheError.normalizationFailed(object: fragment)
        }
            
        return try await withCheckedThrowingContinuation { continuation in
            apollo.withinReadWriteTransaction(
                _: { transaction -> Bool in
                    let cache = try? transaction.readObject(ofType: Fragment.self, withKey: key)
                    return cache != nil
                },
                completion: Self.makeCompletionHandler(continuation: continuation)
            )
        }
    }
    
    func clearCache() async throws {
        try await withCheckedThrowingContinuation { continuation in
            apollo.clearCache(
                completion: Self.makeCompletionHandler(continuation: continuation)
            )
        }
    }
    
    // MARK: - Internal
    
    // MARK: Initializer

    init(apolloStore: ApolloStore) {
        apollo = apolloStore
    }
    
    // MARK: - Private
    
    private let apollo: ApolloStore
    
    private static func makeCompletionHandler<T>(
        completion: @escaping (Result<T, GQLError.CacheError>) -> Void
    ) -> (Result<T, Error>) -> Void {
        { result in
            switch result {
            case let .failure(error):
                let gqlError = parseApolloError(error)
                completion(.failure(gqlError))
            case let .success(data):
                completion(.success(data))
            }
        }
    }
    
    private static func makeCompletionHandler<T>(
        continuation: CheckedContinuation<T, Error>
    ) -> (Result<T, Error>) -> Void {
        { result in
            switch result {
            case let .failure(error):
                let gqlError = parseApolloError(error)
                continuation.resume(throwing: gqlError)
            case let .success(data):
                continuation.resume(returning: data)
            }
        }
    }
    
    private static func parseApolloError(_ error: Error) -> GQLError.CacheError {
        if let cacheError = error as? GQLError.CacheError {
            return cacheError
        }
        // TODO: @tgy Handle each Apollo errors individually
        return .unexpectedError
    }
}
