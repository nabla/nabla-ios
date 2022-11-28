import NablaCore

final class PaginatedWatcherMock: PaginatedWatcher {
    var loadMoreClosure: ((_ completion: @escaping ((Result<Void, NablaError>) -> Void)) -> NablaCancellable)?
    func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> NablaCancellable {
        loadMoreClosure?(completion) ?? NablaCancellableMock()
    }

    func loadMore(numberOfItems _: Int, completion _: @escaping (Result<Void, NablaError>) -> Void) -> NablaCancellable {
        NablaCancellableMock()
    }

    func cancel() {}
    
    func refetch() {}
}
