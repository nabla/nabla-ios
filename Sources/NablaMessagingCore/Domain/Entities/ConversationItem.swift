import Foundation

public protocol ConversationItem {
    var id: UUID { get }
    var date: Date { get }
    var sender: ConversationItemSender { get }
    var state: ConversationItemState { get }
}

public enum ConversationItemSender: Hashable {
    case patient
    case provider(Provider)
    case system
    case deleted
}

public enum ConversationItemState: Hashable {
    case sending
    case sent
    case failed
}
