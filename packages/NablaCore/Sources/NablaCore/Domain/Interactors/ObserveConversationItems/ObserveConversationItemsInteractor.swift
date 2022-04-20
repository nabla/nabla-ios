import Foundation

protocol ObserveConversationItemsInteractor {
    func execute(
        conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> Cancellable
}
