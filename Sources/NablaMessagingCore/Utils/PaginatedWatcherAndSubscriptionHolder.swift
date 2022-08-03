import Foundation
import NablaCore

final class PaginatedWatcherAndSubscriptionHolder: PaginatedWatcher {
    // MARK: - Internal
    
    func refetch() {
        watcher.refetch()
    }
    
    func cancel() {
        watcher.cancel()
        cancellables.removeAll() // Whe do not own the `cancellables`, we only release them. Someone else might still use them.
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
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private let watcher: PaginatedWatcher
    private var cancellables = [Cancellable]()
}
