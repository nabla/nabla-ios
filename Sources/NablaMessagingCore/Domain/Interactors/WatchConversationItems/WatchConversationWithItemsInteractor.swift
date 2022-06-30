import Foundation
import NablaCore

protocol WatchConversationItemsInteractor {
    func execute(
        conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaError>
    ) -> PaginatedWatcher
}
