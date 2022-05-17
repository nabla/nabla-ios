import Foundation

protocol ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId: UUID,
        handler: ResultHandler<ConversationItems, NablaWatchConversationItemsError>
    ) -> PaginatedWatcher
    
    func sendMessage(
        _ message: MessageInput,
        inConversationWithId: UUID,
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> Cancellable
    
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId: UUID,
        handler: ResultHandler<Void, NablaRetrySendingMessageError>
    ) -> Cancellable
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaDeleteMessageError>
    ) -> Cancellable
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSetIsTypingError>
    ) -> Cancellable
    
    func markConversationAsSeen(
        conversationId: UUID,
        handler: ResultHandler<Void, NablaMarkConversationAsSeenError>
    ) -> Cancellable
}
