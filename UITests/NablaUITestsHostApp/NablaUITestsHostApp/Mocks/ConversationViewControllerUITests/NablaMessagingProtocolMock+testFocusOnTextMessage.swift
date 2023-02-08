import Combine
import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestFocusOnTextMessage() {
        setupForTestCreateConversation()

        watchItemsClosure = { _ in
            let list = PaginatedList<ConversationItem>(
                elements: [
                    TextMessageItem(
                        id: .init(),
                        date: .init(),
                        sender: .me,
                        sendingState: .sent,
                        replyTo: nil,
                        content: "World!"
                    ),
                    TextMessageItem(
                        id: .init(),
                        date: .init(),
                        sender: .me,
                        sendingState: .sent,
                        replyTo: nil,
                        content: "Hello"
                    ),
                ],
                loadMore: nil
            )
            let response = Response<PaginatedList<ConversationItem>>(
                data: list,
                isDataFresh: true,
                refreshingState: .refreshed
            )
            return Just(response)
                .setFailureType(to: NablaError.self)
                .eraseToAnyPublisher()
        }
    }
}
