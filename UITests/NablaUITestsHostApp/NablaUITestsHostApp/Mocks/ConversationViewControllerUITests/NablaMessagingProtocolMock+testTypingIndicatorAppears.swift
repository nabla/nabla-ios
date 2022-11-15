import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestTypingIndicatorAppears() {
        setupForTestCreateConversation()

        watchConversationClosure = { _, handler in
            let conversation: Conversation = .mock()
            handler(.success(conversation))
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                handler(.success(Conversation(
                    id: conversation.id,
                    title: conversation.title,
                    subtitle: conversation.subtitle,
                    inboxPreviewTitle: conversation.inboxPreviewTitle,
                    lastMessagePreview: conversation.lastMessagePreview,
                    lastModified: conversation.lastModified,
                    patientUnreadMessageCount: conversation.patientUnreadMessageCount,
                    pictureUrl: nil,
                    providers: [
                        .init(
                            provider: .init(id: .init(), avatarURL: nil, prefix: "Dr", firstName: "John", lastName: "Doe"),
                            typingAt: Date(),
                            seenUntil: Date()
                        ),
                    ],
                    isLocked: false
                )))
            }
            return WatcherMock()
        }

        watchItemsClosure = { _, handler in
            handler(.success(.init(
                hasMore: false,
                items: []
            )))
            return PaginatedWatcherMock()
        }
    }
}
