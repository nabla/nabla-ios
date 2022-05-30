import NablaMessagingCore

final class PaginatedWatcherMock: PaginatedWatcher {
    var loadMoreClosure: ((_ completion: @escaping ((Result<Void, Error>) -> Void)) -> Cancellable)?
    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        loadMoreClosure?(completion) ?? CancellableMock()
    }

    func loadMore(numberOfItems _: Int, completion _: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        CancellableMock()
    }

    func cancel() {}
}
