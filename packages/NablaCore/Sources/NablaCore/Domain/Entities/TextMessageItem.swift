import Foundation

public struct TextMessageItem: ConversationItem {
    public let id: UUID
    public let date: Date
    public let sender: ConversationItemSender
    public let state: ConversationItemState
    public let content: String
}
