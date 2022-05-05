import Foundation

public struct ConversationItems {
    public let conversationId: UUID
    public let hasMore: Bool
    public let items: [ConversationItem]
}
