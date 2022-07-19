import Foundation

// sourcery: AutoMockable
public protocol Watcher: Cancellable {
    func refetch()
}
