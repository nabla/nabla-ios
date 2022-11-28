import Combine
import Foundation
import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    @discardableResult
    func setupForTestCreateConversation() -> CurrentValueSubject<PaginatedList<Conversation>, NablaError> {
        setIsTypingClosure = { _, _ in }
        markConversationAsSeenClosure = { _ in }
        
        let watchConversationsSubject = CurrentValueSubject<PaginatedList<Conversation>, NablaError>(.empty)
        
        watchConversationsClosure = {
            watchConversationsSubject.eraseToAnyPublisher()
        }
        createConversationClosure = { title, _, _ in
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
