import Foundation

final class PaginatedWatcherAndSubscriptionHolder: PaginatedWatcher {
    // MARK: - Internal
    
    func cancel() {
        watcher.cancel()
        cancellables.forEach { $0.cancel() }
    }
    
    func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        watcher.loadMore(completion: completion)
    }
    
    func loadMore(numberOfItems: Int, completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        watcher.loadMore(numberOfItems: numberOfItems, completion: completion)
    }
    
    func hold(_ cancellable: Cancellable) {
        cancellables.append(cancellable)
    }
    
    init(
        watcher: PaginatedWatcher
    ) {
        self.watcher = watcher
    }
    
    // MARK: - Private
    
    private let watcher: PaginatedWatcher
    private var cancellables = [Cancellable]()
}
