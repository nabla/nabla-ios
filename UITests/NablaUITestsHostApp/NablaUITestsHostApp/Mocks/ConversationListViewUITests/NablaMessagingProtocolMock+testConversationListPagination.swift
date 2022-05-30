import Foundation
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestConversationListPagination() {
        let conversation1 = Conversation.mock()
        let conversation2 = Conversation.mock()
        let conversation3 = Conversation.mock()
        
        let paginatedWatcher = PaginatedWatcherMock()
        paginatedWatcher.loadMoreClosure = { completion in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                self.watchConversationsParams.forEach { params in
                    params.handler(.success(ConversationList(
                        conversations: [conversation1, conversation2, conversation3],
                        hasMore: false
                    )))
                }
                completion(.success(()))
            }
            
            return CancellableMock()
        }
        
        watchConversationsClosure = { handler in
            handler(.success(ConversationList(conversations: [conversation1], hasMore: true)))
            return paginatedWatcher
        }
    }
}
