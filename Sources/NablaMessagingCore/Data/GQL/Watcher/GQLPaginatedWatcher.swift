import Foundation
import NablaUtils

protocol PaginatedQuery: GQLQuery {
    static func getCursor(from data: Data) -> String?
}

/// Abstract class
class GQLPaginatedWatcher<Query: PaginatedQuery>: PaginatedWatcher {
    // MARK: - Internal

    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        loadMore(numberOfItems: numberOfItemsPerPage, completion: completion)
    }
    
    func loadMore(numberOfItems: Int, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        gqlClient
            .fetch(
                query: makeQuery(page: .init(cursor: cursor, numberOfItems: numberOfItems)),
                cachePolicy: .fetchIgnoringCacheCompletely,
                handler: .init { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case let .failure(error):
                        completion(.failure(error))
                    case let .success(data):
                        self.cursor = Query.getCursor(from: data)
                        self.handleAdditionalData(data, completion: completion)
                    }
                }
            )
    }
    
    func cancel() {
        watcher?.cancel()
    }
    
    init(
        gqlClient: GQLClient,
        gqlStore: GQLStore,
        numberOfItemsPerPage: Int,
        handler: ResultHandler<Query.Data, GQLError>
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
        self.numberOfItemsPerPage = numberOfItemsPerPage
        self.handler = handler
        
        watcher = gqlClient
            .watch(
                query: makeQuery(page: .init(cursor: nil, numberOfItems: numberOfItemsPerPage)),
                cachePolicy: .fetchIgnoringCacheData,
                handler: .init { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case let .failure(error):
                        handler(.failure(error))
                    case let .success(data):
                        self.cursor = Query.getCursor(from: data)
                        handler(.success(data))
                    }
                }
            )
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
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    
    private let numberOfItemsPerPage: Int
    private let handler: ResultHandler<Query.Data, GQLError>
    
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
