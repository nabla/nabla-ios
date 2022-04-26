import Foundation

public protocol Cancellable: AnyObject {
    func cancel()
}

final class Failure: Cancellable {
    func cancel() {}
}
