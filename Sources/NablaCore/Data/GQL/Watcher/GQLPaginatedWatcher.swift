import Foundation

public protocol PaginatedQuery: GQLQuery {
    static func getCursor(from data: Data) -> String?
}

/// Abstract class
open class GQLPaginatedWatcher<Query: PaginatedQuery>: PaginatedWatcher {
    // MARK: - Public
    
    public func refetch() {
        watcher?.refetch()
    }

    public func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        loadMore(numberOfItems: numberOfItemsPerPage, completion: completion)
    }
    
    public func loadMore(numberOfItems: Int, completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        gqlClient
            .fetch(
                query: makeQuery(cursor: cursor, numberOfItems: numberOfItems),
                cachePolicy: .fetchIgnoringCacheCompletely,
                handler: .init { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case let .failure(error):
                        completion(.failure(GQLErrorTransformer.transform(gqlError: error)))
                    case let .success(data):
                        self.cursor = Query.getCursor(from: data)
                        self.handleAdditionalData(data, completion: completion)
                    }
                }
            )
    }
    
    public func cancel() {
        watcher?.cancel()
    }
    
    // MARK: To override
    
    open func makeQuery(cursor _: String?, numberOfItems _: Int) -> Query {
        fatalError("You must override `GQLPaginatedWatcher.makeQuery(page:)`")
    }
    
    open func updateCache(_: inout Query.Data, withAdditionalData _: Query.Data) {}
    
    // MARK: Intializer
    
    public init(
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
                query: makeQuery(cursor: nil, numberOfItems: numberOfItemsPerPage),
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
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    
    private let numberOfItemsPerPage: Int
    private let handler: ResultHandler<Query.Data, GQLError>
    
    private var watcher: Watcher?
    private var cursor: String?
    
    private func handleAdditionalData(_ data: Query.Data, completion: @escaping (Result<Void, NablaError>) -> Void) {
        gqlStore.updateCache(
            for: makeQuery(cursor: nil, numberOfItems: numberOfItemsPerPage),
            onlyIfExists: true,
            body: { cache in
                self.updateCache(&cache, withAdditionalData: data)
            },
            completion: { result in
                switch result {
                case let .failure(error):
                    completion(.failure(GQLErrorTransformer.transform(gqlError: .cacheError(error))))
                case .success:
                    completion(.success(()))
                }
            }
        )
    }
}
