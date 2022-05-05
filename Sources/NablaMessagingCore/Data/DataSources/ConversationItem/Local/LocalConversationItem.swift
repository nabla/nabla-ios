import Foundation

public protocol LocalConversationItem {
    var clientId: UUID { get }
    var date: Date { get }
    var state: ConversationItemState { get set }
}
