import Apollo
#if canImport(ApolloAPI)
    import ApolloAPI
#endif
import Foundation

class GQLStoreImpl: GQLStore {
    // MARK: - Public
    
    // MARK: GQLStore

    func updateCache<CacheMutation: LocalCacheMutation>(
        cacheMutation: CacheMutation,
        body: @escaping (inout CacheMutation.Data) throws -> Void
    ) async throws {
        try await withCheckedThrowingContinuation { continuation in
            apollo.withinReadWriteTransaction(
                _: { transaction in
                    do {
                        try transaction.update(cacheMutation, body)
                    } catch JSONDecodingError.missingValue {
                        return // If the cache does not exist, silently return
                    } catch {
                        throw error
                    }
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
        return .unexpectedError(error)
    }
}
