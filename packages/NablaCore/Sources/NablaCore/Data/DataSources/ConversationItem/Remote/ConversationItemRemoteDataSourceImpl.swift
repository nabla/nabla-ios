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
    
    // MARK: - Private
    
    @Inject private var gqlClient: GQLClient
}
