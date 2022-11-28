import Combine
import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestTypingIndicatorAppears() {
        let subject = setupForTestCreateConversation()

        watchConversationClosure = { _ in
            guard let conversation = subject.value.elements.first else {
                fatalError("Set up must return at least one conversation")
            }
            let updated = Conversation(
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
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                subject.send(PaginatedList(elements: [updated], loadMore: nil))
            }
            
            return subject
                .compactMap(\.elements.first)
                .eraseToAnyPublisher()
        }

        watchItemsClosure = { _ in
            Just(PaginatedList(elements: [], loadMore: nil))
                .setFailureType(to: NablaError.self)
                .eraseToAnyPublisher()
        }
    }
}
