import Foundation
#if canImport(NablaUtils)
    import NablaUtils
#endif

class ConversationItemRemoteDataSourceImpl: ConversationItemRemoteDataSource {
    // MARK: - Initializer

    init(
        gqlClient: GQLClient,
        gqlStore: GQLStore,
        logger: Logger
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
        self.logger = logger
    }

    // MARK: - Internal
    
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationItems, GQLError>
    ) -> PaginatedWatcher {
        ConversationItemsWatcher(
            gqlClient: gqlClient,
            gqlStore: gqlStore,
            logger: logger,
            conversationId: conversationId,
            numberOfItemsPerPage: Constants.numberOfItemsPerPage,
            handler: handler
        )
    }
    
    func send(
        localMessageClientId: UUID,
        remoteMessageInput: GQL.SendMessageContentInput,
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.SendMessageMutation(
                conversationId: conversationId,
                content: remoteMessageInput,
                clientId: localMessageClientId
            ),
            handler: handler.pullback(void)
        )
    }

    func delete(
        messageId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.DeleteMessageMutation(messageId: messageId),
            handler: handler.pullback(void)
        )
    }

    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<RemoteConversationEvent, GQLError>
    ) -> Cancellable {
        gqlClient.subscribe(subscription: GQL.ConversationEventsSubscription(id: conversationId), handler: .init { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .failure(error):
                handler(.failure(error))
            case let .success(data):
                guard let event = data.conversation?.event else {
                    return
                }
                self.handleConversationEvent(event, inConversationWithId: conversationId)
                handler(.success(event))
            }
        })
    }
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.SetTypingMutation(conversationId: conversationId, isTyping: isTyping),
            handler: handler.pullback(void)
        )
    }
    
    func markConversationAsSeen(
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.MaskAsSeenMutation(conversationId: conversationId),
            handler: handler.pullback(void)
        )
    }
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    private let logger: Logger
    
    private enum Constants {
        static let numberOfItemsPerPage = 50
        
        static func rootQuery(conversationId: UUID) -> GQL.GetConversationItemsQuery {
            .init(id: conversationId, page: .init(cursor: nil, numberOfItems: numberOfItemsPerPage))
        }
    }
    
    private func handleConversationEvent(_ event: RemoteConversationEvent, inConversationWithId conversationId: UUID) {
        if let messageCreatedEvent = event.asMessageCreatedEvent {
            append(
                message: messageCreatedEvent.message.fragments.messageFragment,
                toCacheOfConversationWithId: conversationId
            )
        } else if let typingEvent = event.asTypingEvent {
            update(
                provider: typingEvent.provider.fragments.providerInConversationFragment,
                inCacheOfConversationWithId: conversationId
            )
        }
    }
    
    private func append(message: GQL.MessageFragment, toCacheOfConversationWithId conversationId: UUID) {
        gqlStore.updateCache(
            for: Constants.rootQuery(conversationId: conversationId),
            onlyIfExists: true,
            body: { cache in
                let isAlreadyInConversation = cache.conversation.conversation.items.data.contains(
                    where: { $0?.fragments.conversationItemFragment.id == message.id }
                )
                if !isAlreadyInConversation {
                    cache.conversation.conversation.items.data.append(.init(unsafeResultMap: message.resultMap))
                }
            },
            completion: { _ in }
        )
    }
    
    private func update(provider: GQL.ProviderInConversationFragment, inCacheOfConversationWithId conversationId: UUID) {
        gqlStore.updateCache(
            for: GQL.GetConversationQuery(id: conversationId),
            onlyIfExists: true,
            body: { cache in
                
                let isAlreadyInConversation = cache.conversation.conversation.fragments.conversationFragment.providers.contains(where: { $0.fragments.providerInConversationFragment.id == provider.id })
                
                if !isAlreadyInConversation {
                    cache.conversation.conversation.fragments.conversationFragment.providers.append(.init(unsafeResultMap: provider.resultMap))
                }
            },
            completion: { _ in }
        )
    }
}

extension GQL.GetConversationItemsQuery: PaginatedQuery {
    static func getCursor(from data: Data) -> String? {
        data.conversation.conversation.items.nextCursor
    }
}

private class ConversationItemsWatcher: GQLPaginatedWatcher<GQL.GetConversationItemsQuery> {
    // MARK: - Initializer

    init(
        gqlClient: GQLClient,
        gqlStore: GQLStore,
        logger: Logger,
        conversationId: UUID,
        numberOfItemsPerPage: Int,
        handler: ResultHandler<RemoteConversationItems, GQLError>
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
        self.logger = logger
        self.conversationId = conversationId
        super.init(
            gqlClient: gqlClient,
            gqlStore: gqlStore,
            numberOfItemsPerPage: numberOfItemsPerPage,
            handler: handler
        )
    }
    
    override func makeQuery(page: GQL.OpaqueCursorPage) -> GQL.GetConversationItemsQuery {
        GQL.GetConversationItemsQuery(id: conversationId, page: page)
    }
    
    override func updateCache(_ cache: inout RemoteConversationItems, withAdditionalData data: RemoteConversationItems) {
        let existingIds = Set(cache.conversation.conversation.items.data.compactMap {
            $0?.fragments.conversationItemFragment.id
        })
        let newItems = data.conversation.conversation.items.data.filter { maybeItem in
            guard let item = maybeItem else { return false }
            guard let itemId = item.fragments.conversationItemFragment.id else {
                logger.warning(message: "Unknown item type: \(item.__typename)")
                return false
            }
            if existingIds.contains(itemId) {
                logger.warning(message: "Found duplicated item when loading more: \(item)")
                return false
            }
            return true
        }
        cache.conversation.conversation.items.data.append(contentsOf: newItems)
        cache.conversation.conversation.items.hasMore = data.conversation.conversation.items.hasMore
        cache.conversation.conversation.items.nextCursor = data.conversation.conversation.items.nextCursor
    }
    
    // MARK: - Private

    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    private let logger: Logger
    private let conversationId: UUID
}
