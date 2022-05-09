import Foundation

/// A task than can be cancelled on best effort.
/// You must retain the returned cancellable to make sure
/// the task is performed complitely.
public protocol Cancellable: AnyObject {
    func cancel()
}

final class Failure: Cancellable {
    func cancel() {}
}
