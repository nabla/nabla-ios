import Foundation

protocol ConversationItemRemoteDataSource {
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<GQL.GetConversationItemsQuery.Data, GQLError>) -> Void
    ) -> Cancellable
}
