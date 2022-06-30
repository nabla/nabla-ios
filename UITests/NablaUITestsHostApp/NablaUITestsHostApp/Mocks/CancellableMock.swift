import NablaCore

final class CancellableMock: Cancellable {
    func cancel() {}
}

final class WatcherMock: Watcher {
    func cancel() {}
    
    func refetch() {}
}
