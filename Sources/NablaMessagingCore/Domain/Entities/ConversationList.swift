import Foundation

public struct ConversationList {
    public let conversations: [Conversation]
    public let hasMore: Bool
}

public extension ConversationList {
    static var empty: ConversationList {
        ConversationList(conversations: [], hasMore: false)
    }
}
