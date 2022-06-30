import Foundation

/// A task than can be cancelled on best effort.
/// You must retain the returned cancellable to make sure
/// the task is performed complitely.
// sourcery: AutoMockable
// sourcery: typealias = "Cancellable = NablaCore.Cancellable"
public protocol Cancellable: AnyObject {
    func cancel()
}

public final class Failure: Watcher {
    public func cancel() {}
    public func refetch() {}
    
    public init() {}
}
