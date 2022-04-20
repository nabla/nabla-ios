import Foundation
import NablaUtils

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Internal
    
    func watch(callback: @escaping (Result<ConversationList, GQLError>) -> Void) -> PaginatedWatcher {
        ConversationListWatcher(
            query: GQL.GetConversationsQuery(page: .init(cursor: nil, numberOfItems: nil)),
            callback: callback
        )
    }
    
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        remoteDataSource.createConversation(completion: completion)
    }
    
    // MARK: - Private

    @Inject private var remoteDataSource: ConversationRemoteDataSource
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
                        conversations: data.conversations.conversations.map(Self.transform),
                        hasMore: data.conversations.hasMore
                    )
                })
            }
    }

    // MARK: - PaginatedWatcher

    func cancel() {
        cancellable?.cancel()
    }

    func loadMore(completion: @escaping (Result<Void, GQLError>) -> Void) -> Cancellable {
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

    private static func transform(data: GQL.GetConversationsQuery.Data.Conversation.Conversation) -> Conversation {
        .init(id: data.id)
    }
}
