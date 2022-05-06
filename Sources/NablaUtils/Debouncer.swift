import Foundation

public final class Debouncer {
    public init(
        delay: TimeInterval,
        queue: DispatchQueue
    ) {
        self.delay = delay
        self.queue = queue
    }

    public func execute(_ block: @escaping () -> Void) {
        cancel()
        
        workItem = DispatchWorkItem(block: block)
        
        if let workItem = workItem {
            queue.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }

    public func cancel() {
        workItem?.cancel()
    }

    // MARK: - Private
    
    private let delay: TimeInterval
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
}
