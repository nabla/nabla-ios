import Foundation

public protocol ConversationItem {
    var id: UUID { get }
    var date: Date { get }
}
