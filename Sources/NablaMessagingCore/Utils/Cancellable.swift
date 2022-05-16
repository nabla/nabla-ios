import Foundation

/// A task than can be cancelled on best effort.
/// You must retain the returned cancellable to make sure
/// the task is performed complitely.
// sourcery: AutoMockable
// sourcery: typealias = "Cancellable = NablaMessagingCore.Cancellable"
public protocol Cancellable: AnyObject {
    func cancel()
}

final class Failure: Cancellable {
    func cancel() {}
}
