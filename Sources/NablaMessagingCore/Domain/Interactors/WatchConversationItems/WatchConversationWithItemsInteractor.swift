import Foundation

protocol WatchConversationItemsInteractor {
    func execute(
        conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaWatchConversationItemsError>
    ) -> PaginatedWatcher
}
