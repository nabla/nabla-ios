import Foundation

public struct Conversation {
    public let id: UUID
    public let title: String?
    public let subtitle: String?
    public let inboxPreviewTitle: String
    public let lastMessagePreview: String?
    public let lastModified: Date
    public let patientUnreadMessageCount: Int
    public let pictureUrl: URL?
    public let providers: [ProviderInConversation]
}
