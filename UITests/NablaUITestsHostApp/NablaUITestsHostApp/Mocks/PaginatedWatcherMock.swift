import NablaMessagingCore

final class PaginatedWatcherMock: PaginatedWatcher {
    func loadMore(completion _: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        CancellableMock()
    }

    func loadMore(numberOfItems _: Int, completion _: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        CancellableMock()
    }

    func cancel() {}
}
