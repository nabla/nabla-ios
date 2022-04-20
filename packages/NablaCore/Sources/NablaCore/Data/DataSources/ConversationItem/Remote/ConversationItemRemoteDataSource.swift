import Foundation

protocol ConversationItemRemoteDataSource {
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<GQL.GetConversationItemsQuery.Data, GQLError>) -> Void
    ) -> Cancellable

    func send(
        localMessageClientId: UUID,
        remoteMessageInput: GQL.SendMessageContentInput,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
}
