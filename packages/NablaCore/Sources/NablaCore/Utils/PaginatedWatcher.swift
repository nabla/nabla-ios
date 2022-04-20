import Foundation

public protocol PaginatedWatcher: Cancellable {
    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable
}
