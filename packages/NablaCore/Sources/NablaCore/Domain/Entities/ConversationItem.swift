import Foundation

public protocol ConversationItem {
    var id: UUID { get }
    var date: Date { get }
    var sender: ConversationItemSender { get }
    var state: ConversationItemState { get }
}

public enum ConversationItemSender {
    case system
    case user(UUID)
}

public enum ConversationItemState {
    case sending
    case sent
    case failed
}
