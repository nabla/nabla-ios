import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationItemRemoteDataSource {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationItems, GQLError>
    ) -> PaginatedWatcher
    
    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationEvent, GQLError>
    ) -> Cancellable
    
    func send(
        remoteMessageInput: GQL.SendMessageInput,
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
    
    func delete(
        messageId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
}
