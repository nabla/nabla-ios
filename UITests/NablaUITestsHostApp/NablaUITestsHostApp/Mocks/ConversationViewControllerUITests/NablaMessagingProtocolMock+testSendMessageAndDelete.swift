import Combine
import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestSendMessageAndDelete() {
        setupForTestCreateConversation()
        
        let watchItemsSubject = CurrentValueSubject<PaginatedList<ConversationItem>, Never>(.empty)

        watchItemsClosure = { _ in
            watchItemsSubject
                .setFailureType(to: NablaError.self)
                .map { list in
                    Response(
                        data: list,
                        isDataFresh: true,
                        refreshingState: .refreshed
                    )
                }
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

        deleteMessageClosure = { _, _ in
            self.watchItemsReceivedInvocations.forEach { _ in
                let list = PaginatedList<ConversationItem>(
                    elements: [
                        DeletedMessageItem(id: .init(), date: .init(), sender: .me, sendingState: .sent, replyTo: nil),
                    ],
                    loadMore: nil
                )
                watchItemsSubject.send(list)
            }
        }
    }
}
