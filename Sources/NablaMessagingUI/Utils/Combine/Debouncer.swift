import Foundation

final class Debouncer {
    init(
        delay: TimeInterval,
        queue: DispatchQueue
    ) {
        self.delay = delay
        self.queue = queue
    }
    
    func execute(_ block: @escaping () -> Void) {
        cancel()
        
        workItem = DispatchWorkItem(block: block)
        
        if let workItem = workItem {
            queue.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }

    func cancel() {
        workItem?.cancel()
    }

    // MARK: - Pr
    
    private let delay: TimeInterval
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
}
