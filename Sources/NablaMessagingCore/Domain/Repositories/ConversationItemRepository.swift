import Foundation
import NablaCore

protocol ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId: TransientUUID,
        handler: ResultHandler<ConversationItems, NablaError>
    ) -> PaginatedWatcher
    
    func sendMessage(
        _ message: MessageInput,
        replyToMessageId: UUID?,
        inConversationWithId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
