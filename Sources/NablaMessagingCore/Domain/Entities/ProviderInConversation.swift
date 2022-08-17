import Foundation

public struct ProviderInConversation {
    public let provider: Provider
    public let typingAt: Date?
    public let seenUntil: Date?
    
    public var isTyping: Bool {
        isInactiveAt.map(\.nabla.isFuture) ?? false
    }

    // MARK: - Private

    enum Constants {
        static let typingTimeWindowTimeInterval: TimeInterval = 20
    }

    private var isInactiveAt: Date? {
        typingAt.map { $0.addingTimeInterval(Constants.typingTimeWindowTimeInterval) }
    }
}
