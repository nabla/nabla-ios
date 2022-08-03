import Foundation
import NablaCore

class UmbrellaCancellable: Cancellable {
    func add(_ cancellable: Cancellable) {
        children.append(cancellable)
    }
    
    private(set) var isCancelled: Bool = false
    
    // MARK: - Cancellable
    
    func cancel() {
        children.removeAll() // Whe do not own the `children`, we only release them. Someone else might still use them.
        isCancelled = true
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private var children: [Cancellable] = []
}
