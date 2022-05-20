import Foundation

public struct ConversationActivity: ConversationItem {
    public enum Activity: Hashable {
        case providerJoined(MaybeProvider)
    }

    public let id: UUID
    public let date: Date
    public let activity: Activity
}
