import Apollo

extension Apollo.Cancellable {
    func toNablaCancellable() -> NablaCancellable {
        ApolloCancellable(apollo: self)
    }
}

private class ApolloCancellable: NablaCancellable {
    init(apollo: Apollo.Cancellable) {
        self.apollo = apollo
    }
    
    func cancel() {
        apollo.cancel()
    }
    
    deinit {
        cancel()
    }
    
    private let apollo: Apollo.Cancellable
}
