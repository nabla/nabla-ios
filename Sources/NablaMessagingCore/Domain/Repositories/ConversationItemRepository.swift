import Foundation

public enum ConversationItemRepositoryError: Error {
    case conversationItemNotFound
    case notSupported
}

protocol ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
    ) -> PaginatedWatcher
    
    func sendMessage(
        _ message: MessageInput,
        inConversationWithId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
    
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID
    ) -> Cancellable
    
    func markConversationAsSeen(conversationId: UUID) -> Cancellable
}
