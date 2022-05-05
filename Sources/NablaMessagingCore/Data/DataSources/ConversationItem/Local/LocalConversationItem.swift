import Foundation

protocol LocalConversationItem {
    var clientId: UUID { get }
    var date: Date { get }
}
