import Apollo

extension Apollo.Cancellable {
    func toNablaCancellable() -> NablaCore.Cancellable {
        ApolloCancellable(apollo: self)
    }
}

private class ApolloCancellable: NablaCore.Cancellable {
    init(apollo: Apollo.Cancellable) {
        self.apollo = apollo
    }
    
    func cancel() {
        apollo.cancel()
    }
    
    private let apollo: Apollo.Cancellable
}
