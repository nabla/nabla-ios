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
    ) -> NablaCancellable
    
    func send(
        remoteMessageInput: GQL.SendMessageInput,
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> NablaCancellable
    
    /// - Throws: ``GQLError``
    func delete(messageId: UUID) async throws
}
