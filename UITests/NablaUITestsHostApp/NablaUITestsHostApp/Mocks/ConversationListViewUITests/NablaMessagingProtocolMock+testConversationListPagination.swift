import Combine
import Foundation
@testable import NablaCore
@testable import NablaMessagingCore

extension NablaMessagingClientProtocolMock {
    func setupForTestConversationListPagination() {
        let subject = CurrentValueSubject<PaginatedList<Conversation>, NablaError>(.empty)
        
        let dynamicList = PaginatedList<Conversation>(
            elements: [.mock()],
            loadMore: {
                await withCheckedContinuation { continuation in
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                        let old = subject.value
                        let new = PaginatedList<Conversation>(
                            elements: old.elements + [.mock(), .mock()],
                            loadMore: old.loadMore
                        )
                        subject.send(new)
                        continuation.resume()
                    }
                }
            }
        )
        subject.send(dynamicList)
        
        watchConversationsClosure = {
            subject
                .map { list in
                    Response(
                        data: list,
                        isDataFresh: true,
                        refreshingState: .refreshed
                    )
                }
                .eraseToAnyPublisher()
        }
    }
}
