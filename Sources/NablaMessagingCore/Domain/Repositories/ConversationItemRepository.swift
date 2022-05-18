import Foundation

protocol ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId: UUID,
        handler: ResultHandler<ConversationItems, NablaError>
    ) -> PaginatedWatcher
    
    func sendMessage(
        _ message: MessageInput,
        inConversationWithId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func markConversationAsSeen(
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
