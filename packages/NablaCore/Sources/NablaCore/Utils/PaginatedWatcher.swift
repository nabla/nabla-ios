import Foundation

public protocol PaginatedWatcher: Cancellable {
    func loadMore(completion: @escaping (Result<Void, GQLError>) -> Void) -> Cancellable
}
