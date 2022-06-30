import NablaCore

final class PaginatedWatcherMock: PaginatedWatcher {
    var loadMoreClosure: ((_ completion: @escaping ((Result<Void, NablaError>) -> Void)) -> Cancellable)?
    func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        loadMoreClosure?(completion) ?? CancellableMock()
    }

    func loadMore(numberOfItems _: Int, completion _: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        CancellableMock()
    }

    func cancel() {}
    
    func refetch() {}
}
