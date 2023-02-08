import Combine
import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    @discardableResult
    func setupForTestCreateConversation() -> CurrentValueSubject<PaginatedList<Conversation>, NablaError> {
        setIsTypingClosure = { _, _ in }
        markConversationAsSeenClosure = { _ in }
        
        let watchConversationsSubject = CurrentValueSubject<PaginatedList<Conversation>, NablaError>(.empty)
        
        watchConversationsClosure = {
            watchConversationsSubject
                .map { list in
                    Response(data: list, isDataFresh: true, refreshingState: .refreshed)
                }
                .eraseToAnyPublisher()
        }
        startConversationClosure = { title, _ in
            let created = Conversation.mock(title: title)
            let old = watchConversationsSubject.value
            let new = PaginatedList<Conversation>(
                elements: old.elements + [created],
                loadMore: old.loadMore
            )
            watchConversationsSubject.send(new)
            return created
        }
        
        return watchConversationsSubject
    }
}
