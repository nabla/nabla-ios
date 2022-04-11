import Foundation

protocol ConversationItemRepository {
    func observeConversationItems(
        ofConversationWithId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> Cancellable
}
