import Foundation

public struct ConversationWithItems {
    public let hasMore: Bool
    public let typingProviders: [Provider]
    public let items: [ConversationItem]
}
