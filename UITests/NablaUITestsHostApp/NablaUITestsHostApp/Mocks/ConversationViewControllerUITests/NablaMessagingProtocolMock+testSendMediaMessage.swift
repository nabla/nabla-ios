import Foundation
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestSendMediaMessage() {
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

        sendMessageClosure = { _, _, _ in
            
            self.watchItemsReceivedInvocations.forEach { params in
                params.handler(.success(.init(
                    conversationId: .init(),
                    hasMore: false,
                    items: [
                        ImageMessageItem(
                            id: .init(),
                            date: .init(),
                            sender: .patient,
                            sendingState: .sent,
                            replyTo: nil,
                            content: ImageFile(
                                fileName: "image",
                                fileUrl: URL(string: "https://avatars.githubusercontent.com/u/39350711?s=200&v=4")!, // swiftlint:disable:this force_unwrapping
                                size: .init(width: 200, height: 200),
                                mimeType: .png
                            )
                        ),
                    ]
                )))
            }
            return PaginatedWatcherMock()
        }
    }
}
