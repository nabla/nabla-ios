import Foundation
import NablaCore

protocol ConversationItemRemoteDataSource {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationItems, GQLError>
    ) -> PaginatedWatcher

    func getConversationItems(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationItems, GQLError>
    ) -> Cancellable
    
    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationEvent, GQLError>
    ) -> Cancellable
    
    func send(
        localMessageClientId: UUID,
        remoteMessageInput: GQL.SendMessageContentInput,
        conversationId: UUID,
        replyToMessageId: UUID?,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
    
    func delete(
        messageId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
    
    func markConversationAsSeen(
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
}
