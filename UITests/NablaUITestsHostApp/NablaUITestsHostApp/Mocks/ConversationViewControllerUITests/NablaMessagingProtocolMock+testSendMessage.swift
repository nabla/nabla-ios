import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestSendMessage() {
        setupForTestCreateConversation()

        watchConversationClosure = { _, handler in
            handler(.success(.mock()))
            return WatcherMock()
        }

        watchItemsClosure = { _, handler in
            handler(.success(.init(
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
                    hasMore: false,
                    items: [
                        TextMessageItem(
                            id: .init(),
                            date: .init(),
                            sender: .patient,
                            sendingState: .sending,
                            replyTo: nil,
                            content: textContent
                        ),
                    ]
                )))
            }
            return PaginatedWatcherMock()
        }
    }
}
