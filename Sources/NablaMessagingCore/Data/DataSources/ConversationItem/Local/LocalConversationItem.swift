import Foundation

protocol LocalConversationItem {
    var conversationId: UUID { get }
    var clientId: UUID { get }
    var date: Date { get }
}
