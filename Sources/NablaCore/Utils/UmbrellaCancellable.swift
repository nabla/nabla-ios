import Foundation

public class UmbrellaCancellable: NablaCancellable {
    // MARK: - Public
    
    public func add(_ cancellable: NablaCancellable) {
        children.append(cancellable)
    }
    
    public private(set) var isCancelled: Bool = false
    
    // MARK: Cancellable
    
    public func cancel() {
        children.removeAll() // Whe do not own the `children`, we only release them. Someone else might still use them.
        isCancelled = true
    }
    
    // MARK: Init
    
    public init() {}
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private var children: [NablaCancellable] = []
}
