import Foundation

/// A ``Cancellable`` task that handles pagination.
/// Used to fetch list of items, you must call loadMore when reaching end of list.
/// The items are received via the associated list watcher callback.
// sourcery: AutoMockable
public protocol PaginatedWatcher: Watcher {
    /// Load more items.
    /// The number of items returned is computed by the backed.
    /// - Parameters:
    ///   - completion: The completion to handle whether or not the task failed. The results are received via the associated list watcher callback.
    /// - Returns: The ``Cancellable`` of the task.
    func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> NablaCancellable
    /// Load more items.
    /// - Parameters:
    ///   - numberOfItems: The number of items to load.
    ///   - completion: The completion to handle whether or not the task failed. The results are received via the associated list watcher callback.
    /// - Returns: The ``Cancellable`` of the task.
    func loadMore(numberOfItems: Int, completion: @escaping (Result<Void, NablaError>) -> Void) -> NablaCancellable
}

public final class FailurePaginatedWatcher: PaginatedWatcher {
    public func refetch() {}
    
    public func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> NablaCancellable {
        Failure(handler: .init(completion), error: error)
    }

    public func loadMore(numberOfItems _: Int, completion: @escaping (Result<Void, NablaError>) -> Void) -> NablaCancellable {
        Failure(handler: .init(completion), error: error)
    }

    public func cancel() {}
    
    public init<T, E: NablaError>(handler: ResultHandler<T, E>, error: E) {
        self.error = error
        handler(.failure(error))
    }
    
    private let error: NablaError
}
