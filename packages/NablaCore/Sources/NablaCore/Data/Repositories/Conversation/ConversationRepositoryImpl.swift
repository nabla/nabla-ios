import Foundation
import NablaUtils

class ConversationRepositoryImpl: ConversationRepository {
    func watch(callback: @escaping (Result<ConversationList, GQLError>) -> Void) -> PaginatedWatcher {
        ConversationListWatcher(
            query: GQL.GetConversationsQuery(page: .init(cursor: nil, numberOfItems: nil)),
            callback: callback
        )
    }

    @Inject private var gqlClient: GQLClient
}

private class ConversationListWatcher: PaginatedWatcher {
    // MARK: - Initializer

    init(query: GQL.GetConversationsQuery,
         callback: @escaping (Result<ConversationList, GQLError>) -> Void) {
        self.callback = callback
        self.query = query

        cancellable = gqlClient
            .watch(
                query: GQL.GetConversationsQuery(page: .init(cursor: nil, numberOfItems: nil)),
                cachePolicy: .returnCacheDataAndFetch
            ) { [weak self] result in
                self?.cursor = result.value?.conversations.nextCursor

                callback(result.map { data in
                    // TODO: (tgy) - Update cache
                    ConversationList(
                        conversations: data.conversations.conversations.map { _ in Conversation() },
                        hasMore: data.conversations.hasMore
                    )
                })
            }
    }

    // MARK: - PaginatedWatcher

    func cancel() {
        cancellable?.cancel()
    }

    func loadMore(completion: @escaping (Result<Void, GQLError>) -> Void) {
        gqlClient
            .fetch(
                query: GQL.GetConversationsQuery(page: .init(cursor: cursor, numberOfItems: nil)),
                cachePolicy: .returnCacheDataAndFetch
            ) { [weak self] result in
                self?.cursor = result.value?.conversations.nextCursor
                // TODO: (tgy) - Update cache
                
                completion(result.map { _ in () })
            }
    }

    deinit {
        cancel()
    }

    // MARK: - Private

    private let query: GQL.GetConversationsQuery
    private let callback: (Result<ConversationList, GQLError>) -> Void

    private var cancellable: Cancellable?
    private var cursor: String?

    @Inject private var gqlClient: GQLClient
}
