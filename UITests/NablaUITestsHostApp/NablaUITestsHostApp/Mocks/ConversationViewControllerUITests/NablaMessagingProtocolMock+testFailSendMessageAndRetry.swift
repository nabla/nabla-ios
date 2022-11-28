import Combine
import Foundation
import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestFailSendMessageAndRetry() {
        setupForTestCreateConversation()
        
        let watchItemsSubject = CurrentValueSubject<PaginatedList<ConversationItem>, Never>(.empty)

        watchItemsClosure = { _ in
            watchItemsSubject
                .setFailureType(to: NablaError.self)
                .eraseToAnyPublisher()
        }

        var textContent = ""
        let textMessageId = UUID()

        sendMessageClosure = { message, _ in
            if case let .text(content) = message {
                textContent = content
            }
            self.watchItemsReceivedInvocations.forEach { _ in
                let list = PaginatedList<ConversationItem>(
                    elements: [
                        TextMessageItem(
                            id: textMessageId,
                            date: Date(),
                            sender: .me,
                            sendingState: .failed,
                            replyTo: nil,
                            content: textContent
                        ),
                    ],
                    loadMore: nil
                )
                watchItemsSubject.send(list)
            }
        }

        retrySendingClosure = { _, _ in
            self.watchItemsReceivedInvocations.forEach { _ in
                let list = PaginatedList<ConversationItem>(
                    elements: [
                        TextMessageItem(
                            id: textMessageId,
                            date: .init(),
                            sender: .me,
                            sendingState: .sent,
                            replyTo: nil,
                            content: textContent
                        ),
                    ],
                    loadMore: nil
                )
                watchItemsSubject.send(list)
            }
        }
    }
}
