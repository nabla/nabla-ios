import Foundation

protocol WatchConversationWithItemsInteractor {
    func execute(
        conversationId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
    ) -> PaginatedWatcher
}
