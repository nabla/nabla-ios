import Foundation

/// A task than can be cancelled on best effort.
/// You must retain the returned cancellable to make sure
/// the task is performed complitely.
// sourcery: AutoMockable
public protocol NablaCancellable: AnyObject {
    func cancel()
}

public final class Failure<T, E: Error>: Watcher {
    public func cancel() {}
    public func refetch() {}
    
    public init(handler: ResultHandler<T, E>, error: E) {
        handler(.failure(error))
    }
}

public final class Success: Watcher {
    public func cancel() {}
    public func refetch() {}
    
    public init<T, E: Error>(handler: ResultHandler<T, E>, value: T) {
        handler(.success(value))
    }
    
    public init<E: Error>(handler: ResultHandler<Void, E>) {
        handler(.success(()))
    }
}
