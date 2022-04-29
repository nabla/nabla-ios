import Foundation

public struct DeleteMessageItem: ConversationItem {
    public let id: UUID
    public let date: Date
    public let sender: ConversationItemSender
    public let state: ConversationItemState
}
