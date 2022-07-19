import Foundation
import NablaCore

class UmbrellaCancellable: Cancellable {
    func add(_ cancellable: Cancellable) {
        children.append(cancellable)
    }
    
    private(set) var isCancelled: Bool = false
    
    // MARK: - Cancellable
    
    func cancel() {
        children.forEach { $0.cancel() }
        isCancelled = true
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private var children: [Cancellable] = []
}
