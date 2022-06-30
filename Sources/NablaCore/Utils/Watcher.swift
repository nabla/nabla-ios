import Foundation

public protocol Watcher: Cancellable {
    func refetch()
}
