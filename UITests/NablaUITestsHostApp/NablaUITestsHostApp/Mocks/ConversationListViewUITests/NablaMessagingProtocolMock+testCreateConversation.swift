import Foundation
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestCreateConversation() {
        createConversationClosure = { _ in
            self.watchConversationsParams
                .forEach { params in
                    params.handler(.success(ConversationList(conversations: [.mock()], hasMore: false)))
                }
            return CancellableMock()
        }
    }
}
