import Foundation

protocol ConversationItemRemoteDataSource {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<RemoteConversationWithItems, GQLError>) -> Void
    ) -> PaginatedWatcher
    
    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<RemoteConversationEvent, GQLError>) -> Void
    ) -> Cancellable

    func send(
        localMessageClientId: UUID,
        remoteMessageInput: GQL.SendMessageContentInput,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
}
