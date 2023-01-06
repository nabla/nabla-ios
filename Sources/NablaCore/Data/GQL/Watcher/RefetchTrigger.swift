import Combine
import Foundation

open class RefetchTrigger {
    // MARK: - Public
    
    open var identifier: String {
        UUID().uuidString
    }
    
    public func trigger() {
        Self.refetchSubject.send()
    }
    
    // MARK: - Internal
    
    static let refetchPublisher = refetchSubject.eraseToAnyPublisher()
    
    // MARK: - Private
    
    private static let refetchSubject = PassthroughSubject<Void, Never>()
}
