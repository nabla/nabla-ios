import Foundation
import NablaUtils

class ConversationItemRemoteDataSourceImpl: ConversationItemRemoteDataSource {
    // MARK: - Internal
    
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<GQL.GetConversationItemsQuery.Data, GQLError>) -> Void
    ) -> Cancellable {
        let page = GQL.OpaqueCursorPage(cursor: nil, numberOfItems: 20)
        return gqlClient.watch(
            query: GQL.GetConversationItemsQuery(id: conversationId, page: page),
            cachePolicy: .returnCacheDataAndFetch,
            callback: callback
        )
    }

    func send(
        localMessageClientId: UUID,
        remoteMessageInput: GQL.SendMessageContentInput,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.SendMessageMutation(
                conversationId: conversationId,
                content: remoteMessageInput,
                clientId: localMessageClientId
            ),
            completion: { result in
                callback(result.map { _ in () }.mapError { $0 as Error })
            }
        )
    }
    
    // MARK: - Private
    
    @Inject private var gqlClient: GQLClient
}
