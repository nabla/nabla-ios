import Foundation

public struct ConversationWithItems {
    public let title: String?
    public let avatarURL: String?
    public let hasMore: Bool
    public let typingProviders: [Provider]
    public let items: [ConversationItem]
}
