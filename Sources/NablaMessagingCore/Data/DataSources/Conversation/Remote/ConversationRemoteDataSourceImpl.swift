import Foundation

final class ConversationRemoteDataSourceImpl: ConversationRemoteDataSource {
    // MARK: - Initializer

    init(
        gqlClient: GQLClient,
        gqlStore: GQLStore
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
    }
    
    // MARK: - Internal
    
    func createConversation(
        title: String?,
        providerIdToAssign: UUID?,
        handler: ResultHandler<RemoteConversation, GQLError>
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.CreateConversationMutation(
                title: title,
                providerIdToAssign: providerIdToAssign
            ),
            handler: handler.pullback { $0.createConversation.conversation.fragments.conversationFragment }
        )
    }
    
    func watchConversation(
        _ conversationId: UUID,
        handler: ResultHandler<RemoteConversation, GQLError>
    ) -> Cancellable {
        gqlClient.watch(
            query: GQL.GetConversationQuery(id: conversationId),
            cachePolicy: .returnCacheDataAndFetch,
            handler: handler.pullback { $0.conversation.conversation.fragments.conversationFragment }
        )
    }
    
    func watchConversations(handler: ResultHandler<RemoteConversationList, GQLError>) -> PaginatedWatcher {
        ConversationListWatcher(
            gqlClient: gqlClient,
            gqlStore: gqlStore,
            numberOfItemsPerPage: Constants.numberOfItemsPerPage,
            handler: handler
        )
    }
    
    func subscribeToConversationsEvents(
        handler: ResultHandler<RemoteConversationsEvent, GQLError>
    ) -> Cancellable {
        gqlClient.subscribe(
            subscription: GQL.ConversationsEventsSubscription(),
            handler: .init { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case let .failure(error):
                    handler(.failure(error))
                case let .success(data):
                    guard let event = data.conversations?.event else {
                        return
                    }
                    self.handleConversationsEvent(event)
                    handler(.success(event))
                }
            }
        )
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let numberOfItemsPerPage = 50
        static let conversationsRootQuery = GQL.GetConversationsQuery(
            page: .init(cursor: nil, numberOfItems: numberOfItemsPerPage)
        )
    }
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    
    private func handleConversationsEvent(_ event: RemoteConversationsEvent) {
        if let conversationCreatedEvent = event.asConversationCreatedEvent {
            appendToCache(
                conversation: conversationCreatedEvent.conversation.fragments.conversationFragment
            )
        } else if let conversationDeletedEvent = event.asConversationDeletedEvent {
            removeFromCache(conversationId: conversationDeletedEvent.conversationId)
        }
    }
    
    private func appendToCache(conversation: GQL.ConversationFragment) {
        gqlStore.updateCache(
            for: Constants.conversationsRootQuery,
            onlyIfExists: true,
            body: { cache in
                cache.conversations.conversations.append(.init(unsafeResultMap: conversation.resultMap))
            },
            completion: { _ in }
        )
    }
    
    private func removeFromCache(conversationId: UUID) {
        gqlStore.updateCache(
            for: Constants.conversationsRootQuery,
            onlyIfExists: true,
            body: { cache in
                cache.conversations.conversations.removeAll(where: { $0.fragments.conversationFragment.id == conversationId })
            },
            completion: { _ in }
        )
    }
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
