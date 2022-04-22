import Foundation
import NablaUtils

final class ConversationRemoteDataSourceImpl: ConversationRemoteDataSource {
    // MARK: - Internal
    
    func createConversation(completion: @escaping (Result<RemoteConversation, GQLError>) -> Void) -> Cancellable {
        gqlClient.perform(mutation: GQL.CreateConversationMutation()) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                completion(.success(data.createConversation.conversation.fragments.conversationFragment))
            }
        }
    }
    
    func watchConversations(callback: @escaping (Result<RemoteConversationList, GQLError>) -> Void) -> PaginatedWatcher {
        ConversationListWatcher(numberOfItemsPerPage: 50, callback: callback)
    }

    // MARK: - Private

    @Inject private var gqlClient: GQLClient
}

extension GQL.GetConversationsQuery: PaginatedQuery {
    static func getCursor(from data: Data) -> String? {
        data.conversations.nextCursor
    }
}

private class ConversationListWatcher: GQLPaginatedWatcher<GQL.GetConversationsQuery> {
    // MARK: - Initializer

    override func makeQuery(page: GQL.OpaqueCursorPage) -> GQL.GetConversationsQuery {
        GQL.GetConversationsQuery(page: page)
    }
    
    override func updateCache(_ cache: inout RemoteConversationList, withAdditionalData data: RemoteConversationList) {
        cache.conversations.conversations.append(contentsOf: data.conversations.conversations)
        cache.conversations.hasMore = data.conversations.hasMore
        cache.conversations.nextCursor = data.conversations.nextCursor
    }
}
