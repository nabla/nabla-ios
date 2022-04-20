import Foundation
import NablaUtils

private enum Constants {
    static var rootQuery: GQL.GetConversationsQuery {
        .init(page: .init(cursor: nil, numberOfItems: nil))
    }
}

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Internal

    func watch(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        ConversationListWatcher(
            query: Constants.rootQuery,
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
         callback: @escaping (Result<ConversationList, Error>) -> Void) {
        self.query = query

        cancellable = gqlClient
            .watch(
                query: query,
                cachePolicy: .returnCacheDataAndFetch
            ) { [weak self] result in
                self?.cursor = result.value?.conversations.nextCursor

                callback(
                    result
                        .map { data in
                            ConversationList(
                                conversations: ConversationTransformer.transform(fragment: data),
                                hasMore: data.conversations.hasMore
                            )
                        }
                        .mapError { $0 as Error }
                )
            }
    }

    // MARK: - PaginatedWatcher

    func cancel() {
        cancellable?.cancel()
    }

    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        gqlClient
            .fetch(
                query: GQL.GetConversationsQuery(page: .init(cursor: cursor, numberOfItems: nil)),
                cachePolicy: .returnCacheDataAndFetch
            ) { [weak self] result in
                self?.cursor = result.value?.conversations.nextCursor

                completion(
                    result
                        .map { data in
                            self?.append(data: data.conversations)
                        }
                        .mapError { $0 as Error }
                )
            }
    }

    deinit {
        cancel()
    }

    // MARK: - Private

    private let query: GQL.GetConversationsQuery

    private var cancellable: Cancellable?
    private var cursor: String?

    @Inject private var gqlClient: GQLClient
    @Inject private var gqlStore: GQLStore

    private func append(data: GQL.GetConversationsQuery.Data.Conversation) {
        gqlStore.updateCache(
            for: Constants.rootQuery,
            onlyIfExists: true,
            body: { cache in
                let conversations = data.conversations.map { GQL.GetConversationsQuery.Data.Conversation.Conversation(unsafeResultMap: $0.resultMap) }
                cache.conversations.conversations.append(contentsOf: conversations)
                cache.conversations.hasMore = data.hasMore
                cache.conversations.nextCursor = data.nextCursor
            },
            completion: { _ in }
        )
    }
}
