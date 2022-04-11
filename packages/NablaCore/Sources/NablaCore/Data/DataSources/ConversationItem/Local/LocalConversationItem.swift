import Foundation

public protocol LocalConversationItem {
    var id: UUID { get }
    var clientId: UUID { get }
    var date: Date { get }
    var sender: ConversationItemSender { get }
    var state: ConversationItemState { get set }
}
