import Combine
import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestSendMessage() {
        setupForTestCreateConversation()
        
        let watchItemsSubject = CurrentValueSubject<PaginatedList<ConversationItem>, NablaError>(.empty)

        watchItemsClosure = { _ in
            watchItemsSubject
                .map { list in
                    Response(
                        data: list,
                        isDataFresh: true,
                        refreshingState: .refreshed
                    )
                }
                .eraseToAnyPublisher()
        }

        sendMessageClosure = { message, _ in
            var textContent = ""
            if case let .text(content) = message {
                textContent = content
            }
            self.watchItemsReceivedInvocations.forEach { _ in
                let list = PaginatedList<ConversationItem>(
                    elements: [
                        TextMessageItem(
                            id: .init(),
                            date: .init(),
                            sender: .me,
                            sendingState: .sending,
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
