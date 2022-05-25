import Foundation
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    private static var conversationList: ConversationList = .init(
        conversations: [
            Conversation(
                id: UUID(),
                title: "New conversation",
                description: "Description",
                inboxPreviewTitle: "inboxPreviewTitle",
                lastMessagePreview: "lastMessagePreview",
                lastModified: Date(),
                patientUnreadMessageCount: 1,
                providers: []
            ),
        ],
        hasMore: false
    )

    func setupForTestCreateConversation() {
        createConversationClosure = { _ in
            self.watchConversationsParams
                .forEach { params in
                    params.handler(.success(Self.conversationList))
                }
            return CancellableMock()
        }
    }
}
