import Foundation
@testable import NablaMessagingCore

extension Conversation {
    static func mock() -> Conversation {
        conversationCount += 1
        return Conversation(
            id: .init(),
            title: "Title \(conversationCount)",
            description: "Description \(conversationCount)",
            inboxPreviewTitle: "PreviewTitle \(conversationCount)",
            lastMessagePreview: "MessagePreview \(conversationCount)",
            lastModified: .init(timeIntervalSinceReferenceDate: 0),
            patientUnreadMessageCount: 0,
            providers: []
        )
    }
    
    private static var conversationCount = 0
}
