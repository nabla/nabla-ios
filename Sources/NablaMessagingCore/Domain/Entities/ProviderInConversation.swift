import Foundation

public struct ProviderInConversation {
    public let provider: Provider
    public let typingAt: Date?
    public let seenUntil: Date?
    
    private static let typingTimeWindowTimeInterval: TimeInterval = 20
    
    private func isInactiveAt() -> Date? {
        if let typingAt = typingAt {
            return typingAt.addingTimeInterval(ProviderInConversation.typingTimeWindowTimeInterval)
        } else {
            return nil
        }
    }
    
    public var isTyping: Bool {
        let isInactiveAt = isInactiveAt()
        if let isInactiveAt = isInactiveAt {
            return isInactiveAt.timeIntervalSince1970 > Date().timeIntervalSince1970
        } else {
            return false
        }
    }
}
