import Foundation

public struct ConversationActivity: ConversationItem {
    public enum Content: Hashable {
        case providerJoined(MaybeProvider)
    }

    public let id: UUID
    public let date: Date
    public let content: Content
}
