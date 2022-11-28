import NablaCore

final class NablaCancellableMock: NablaCancellable {
    func cancel() {}
}

final class WatcherMock: Watcher {
    func cancel() {}
    
    func refetch() {}
}
