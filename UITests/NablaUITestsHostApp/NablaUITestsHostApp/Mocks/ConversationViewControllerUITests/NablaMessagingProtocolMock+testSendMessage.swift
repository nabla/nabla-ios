import Foundation
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestSendMessage() {
        setupForTestCreateConversation()

        watchConversationClosure = { _, handler in
            handler(.success(.mock()))
            return CancellableMock()
        }

        watchItemsClosure = { _, handler in
            handler(.success(.init(
                conversationId: .init(),
                hasMore: false,
                items: []
            )))
            return PaginatedWatcherMock()
        }

        sendMessageClosure = { message, _, _ in
            var textContent = ""
            if case let .text(content) = message {
                textContent = content
            }
            self.watchItemsReceivedInvocations.forEach { params in
                params.handler(.success(.init(
                    conversationId: .init(),
                    hasMore: false,
                    items: [
                        TextMessageItem(
                            id: .init(),
                            date: .init(),
                            sender: .patient,
                            sendingState: .sending,
                            content: textContent
                        ),
                    ]
                )))
            }
            return PaginatedWatcherMock()
        }
    }
}
