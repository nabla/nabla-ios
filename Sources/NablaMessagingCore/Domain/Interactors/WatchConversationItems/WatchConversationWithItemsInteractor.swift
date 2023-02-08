import Combine
import Foundation
import NablaCore

protocol WatchConversationItemsInteractor {
    func execute(conversationId: UUID) -> AnyPublisher<Response<PaginatedList<ConversationItem>>, NablaError>
}
