import Foundation

public protocol ConversationMessage: ConversationItem {
    var sender: ConversationMessageSender { get }
    var sendingState: ConversationMessageSendingState { get }
    var replyTo: ConversationMessage? { get }
}

public enum ConversationMessageSender: Hashable {
    case patient
    case provider(Provider)
    case system(SystemProvider)
    case deleted
    case unknown // For cases that this version of the SDK doesn't handle
}

public enum ConversationMessageSendingState: Hashable {
    case toBeSent
    case sending
    case sent
    case failed
}
