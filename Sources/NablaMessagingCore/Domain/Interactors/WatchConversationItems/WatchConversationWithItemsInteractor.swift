import Combine
import Foundation
import NablaCore

protocol WatchConversationItemsInteractor {
    func execute(conversationId: UUID) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError>
}
