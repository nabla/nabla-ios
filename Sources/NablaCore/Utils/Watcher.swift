import Foundation

// sourcery: AutoMockable
public protocol Watcher: NablaCancellable {
    func refetch()
}
