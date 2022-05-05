import Foundation

protocol WatchConversationItemsInteractor {
    func execute(
        conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> PaginatedWatcher
}
