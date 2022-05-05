import Foundation

public protocol ConversationMessage: ConversationItem {
    var sender: ConversationMessageSender { get }
    var sendingState: ConversationMessageSendingState { get }
}

public enum ConversationMessageSender: Hashable {
    case patient
    case provider(Provider)
    case system
    case deleted
}

public enum ConversationMessageSendingState: Hashable {
    case toBeSent
    case sending
    case sent
    case failed
}
