import Foundation

public protocol Cancellable: AnyObject {
    func cancel()
}
