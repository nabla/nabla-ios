import Foundation
import NablaUtils

protocol PaginatedQuery: GQLQuery {
    static func getCursor(from data: Data) -> String?
}

/// Abstract class
class GQLPaginatedWatcher<Query: PaginatedQuery>: PaginatedWatcher {
    // MARK: - Internal
    
    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        gqlClient
            .fetch(
                query: makeQuery(page: .init(cursor: cursor, numberOfItems: numberOfItemsPerPage)),
                cachePolicy: .fetchIgnoringCacheCompletely
            ) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(data):
                    self.cursor = Query.getCursor(from: data)
                    self.handleAdditionalData(data, completion: completion)
                }
            }
    }
    
    func cancel() {
        watcher?.cancel()
    }
    
    init(
        numberOfItemsPerPage: Int?,
        callback: @escaping (Result<Query.Data, GQLError>) -> Void
    ) {
        self.numberOfItemsPerPage = numberOfItemsPerPage
        self.callback = callback
        
        watcher = gqlClient
            .watch(
                query: makeQuery(page: .init(cursor: nil, numberOfItems: numberOfItemsPerPage)),
                cachePolicy: .returnCacheDataAndFetch
            ) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    callback(.failure(error))
                case let .success(data):
                    self.cursor = Query.getCursor(from: data)
                    callback(.success(data))
                }
            }
    }
    
    deinit {
        cancel()
    }
    
    // MARK: To override
    
    open func makeQuery(page _: GQL.OpaqueCursorPage) -> Query {
        fatalError("You must override `GQLPaginatedWatcher.makeQuery(page:)`")
    }
    
    open func updateCache(_: inout Query.Data, withAdditionalData _: Query.Data) {}
    
    // MARK: - Private
    
    @Inject private var gqlClient: GQLClient
    @Inject private var gqlStore: GQLStore
    
    private let numberOfItemsPerPage: Int?
    private let callback: (Result<Query.Data, GQLError>) -> Void
    
    private var watcher: Cancellable?
    private var cursor: String?
    
    private func handleAdditionalData(_ data: Query.Data, completion: @escaping (Result<Void, Error>) -> Void) {
        gqlStore.updateCache(
            for: makeQuery(page: .init(cursor: nil, numberOfItems: numberOfItemsPerPage)),
            onlyIfExists: true,
            body: { cache in
                self.updateCache(&cache, withAdditionalData: data)
            },
            completion: { result in
                switch result {
                case let .failure(error):
                    completion(.failure(GQLError.cacheError(error)))
                case .success:
                    completion(.success(()))
                }
            }
        )
    }
}
