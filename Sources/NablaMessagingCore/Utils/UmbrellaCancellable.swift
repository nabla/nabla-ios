import Foundation
import NablaCore

class UmbrellaCancellable: Cancellable {
    func add(_ cancellable: Cancellable) {
        queue.append(cancellable)
    }
    
    private(set) var isCancelled: Bool = false
    
    // MARK: - Cancellable
    
    func cancel() {
        queue.forEach { $0.cancel() }
        isCancelled = true
    }
    
    // MARK: - Private
    
    private var queue: [Cancellable] = []
}
