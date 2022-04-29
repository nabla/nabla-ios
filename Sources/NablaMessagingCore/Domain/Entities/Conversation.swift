import Foundation

public struct Conversation {
    public let id: UUID
    public let avatarURL: String?
    public let initials: String?
    public let title: String?
    public let lastMessagePreview: String?
    public let lastUpdatedTime: Date
    public let isUnread: Bool
    public init(
        id: UUID,
        avatarURL: String?,
        initials: String?,
        title: String?,
        lastMessagePreview: String?,
        lastUpdatedTime: Date,
        isUnread: Bool
    ) {
        self.id = id
        self.avatarURL = avatarURL
        self.initials = initials
        self.title = title
        self.lastMessagePreview = lastMessagePreview
        self.lastUpdatedTime = lastUpdatedTime
        self.isUnread = isUnread
    }
}
