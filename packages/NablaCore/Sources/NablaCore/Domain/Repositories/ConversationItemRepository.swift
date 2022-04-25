import Foundation

protocol ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
    ) -> Cancellable

    func sendMessage(
        _ message: MessageInput,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable

    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID
    ) -> Cancellable
}
