import Foundation
@testable import NablaMessagingCore

extension Conversation {
    static func mock(
        id: UUID = .init(),
        title: String? = nil
    ) -> Conversation {
        conversationCount += 1
        return Conversation(
            id: id,
            title: title ?? "Title \(conversationCount)",
            subtitle: "Subtitle \(conversationCount)",
            inboxPreviewTitle: "PreviewTitle \(conversationCount)",
            lastMessagePreview: "MessagePreview \(conversationCount)",
            lastMessage: nil,
            lastModified: .init(timeIntervalSinceReferenceDate: 0),
            patientUnreadMessageCount: 0,
            pictureUrl: nil,
            providers: [],
            isLocked: false,
            isLocalOnly: false
        )
    }
    
    private static var conversationCount = 0
}
