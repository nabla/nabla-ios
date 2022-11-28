import Combine
import Foundation
import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestSendMediaMessage() {
        setupForTestCreateConversation()
        
        let watchItemsSubject = CurrentValueSubject<PaginatedList<ConversationItem>, NablaError>(.empty)

        watchItemsClosure = { _ in
            watchItemsSubject.eraseToAnyPublisher()
        }

        sendMessageClosure = { _, _ in
            self.watchItemsReceivedInvocations.forEach { _ in
                let list = PaginatedList<ConversationItem>(
                    elements: [
                        ImageMessageItem(
                            id: .init(),
                            date: .init(),
                            sender: .me,
                            sendingState: .sent,
                            replyTo: nil,
                            content: ImageFile(
                                fileName: "image",
                                source: .url(URL(string: "https://avatars.githubusercontent.com/u/39350711?s=200&v=4")!), // swiftlint:disable:this force_unwrapping
                                size: .init(width: 200, height: 200),
                                mimeType: .png
                            )
                        ),
                    ],
                    loadMore: nil
                )
                watchItemsSubject.send(list)
            }
        }
    }
}
