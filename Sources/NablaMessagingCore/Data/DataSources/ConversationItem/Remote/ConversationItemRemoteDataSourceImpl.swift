import Combine
import Foundation
import NablaCore

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
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<AnyResponse<PaginatedList<RemoteConversationItem>, GQLError>, GQLError> {
        let watcher = gqlClient.watchAndUpdate(
            query: Constants.rootQuery(conversationId: conversationId)
        )
        
        let makeLoadMore: (String?) -> () async throws -> Void = { [weak self] cursor in
            {
                guard let self = self else { return }
                let response = try await self.gqlClient.fetch(
                    query: Constants.pageQuery(conversationId: conversationId, cursor: cursor),
                    policy: .fetchIgnoringCacheCompletely
                )
                try await self.handleLoadMoreConversationItems(data: response, conversationId: conversationId)
            }
        }
        
        return watcher
            .map { response -> AnyResponse<PaginatedList<RemoteConversationItem>, GQLError> in
                response.mapData { data in
                    let items = data.conversation.conversation.items
                    return PaginatedList(
                        elements: items.data.compactMap { $0?.fragments.conversationItemFragment },
                        loadMore: items.hasMore ? makeLoadMore(items.nextCursor) : nil
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func send(
        remoteMessageInput: GQL.SendMessageInput,
        conversationId: UUID
    ) async throws {
        let response = try await gqlClient.perform(
            mutation: GQL.SendMessageMutation(
                conversationId: conversationId,
                input: remoteMessageInput
            )
        )
        let item = GQL.ConversationItemFragment(
            message: response.sendMessageV2.message.fragments.messageFragment
        )
        try await append(item: item, toCacheOfConversationWithId: conversationId)
    }

    func delete(messageId: UUID) async throws {
        _ = try await gqlClient.perform(mutation: GQL.DeleteMessageMutation(messageId: messageId))
    }

    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<RemoteConversationEvent, Never> {
        gqlClient.subscribe(subscription: GQL.ConversationEventsSubscription(id: conversationId))
            .compactMap { $0.conversation?.event }
            .handleEvents(receiveOutput: { event in
                Task { [weak self] in
                    try await self?.handleConversationEvent(event, inConversationWithId: conversationId)
                }
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    private let logger: Logger
    
    private enum Constants {
        static let numberOfItemsPerPage = 50
        
        static func rootQuery(conversationId: UUID) -> GQL.GetConversationItemsQuery {
            pageQuery(conversationId: conversationId, cursor: nil)
        }
        
        static func pageQuery(conversationId: UUID, cursor: String??) -> GQL.GetConversationItemsQuery {
            .init(id: conversationId, page: .init(cursor: cursor, numberOfItems: numberOfItemsPerPage))
        }
    }
    
    private func handleConversationEvent(_ event: RemoteConversationEvent, inConversationWithId conversationId: UUID) async throws {
        if let messageCreatedEvent = event.asMessageCreatedEvent {
            let item = GQL.ConversationItemFragment(
                message: messageCreatedEvent.message.fragments.messageFragment
            )
            try await append(
                item: item,
                toCacheOfConversationWithId: conversationId
            )
        } else if let messageUpdatedEvent = event.asMessageUpdatedEvent {
            logger.info(message: "Message update", extra: ["message": messageUpdatedEvent.message.fragments.messageFragment.id])
        } else if let typingEvent = event.asTypingEvent {
            logger.info(message: "Typing event", extra: ["provider": typingEvent.provider.fragments.providerInConversationFragment.id])
        } else if let conversationActivityCreated = event.asConversationActivityCreated {
            let item = GQL.ConversationItemFragment(
                conversationActivity: conversationActivityCreated.activity.fragments.conversationActivityFragment
            )
            try await append(
                item: item,
                toCacheOfConversationWithId: conversationId
            )
        } else if event.asSubscriptionReadinessEvent != nil {
            // Do nothing
        } else {
            logger.warning(message: "Unknown conversation event", extra: ["event": event.__typename])
        }
    }
    
    private func append(item: GQL.ConversationItemFragment, toCacheOfConversationWithId conversationId: UUID) async throws {
        try await gqlStore.updateCache(
            for: Constants.rootQuery(conversationId: conversationId),
            onlyIfExists: true,
            body: { cache in
                let isAlreadyInConversation = cache.conversation.conversation.items.data.contains(
                    where: { $0?.fragments.conversationItemFragment.id == item.id }
                )
                if !isAlreadyInConversation {
                    cache.conversation.conversation.items.data.append(.init(unsafeResultMap: item.resultMap))
                }
            }
        )
    }
    
    private func handleLoadMoreConversationItems(data: GQL.GetConversationItemsQuery.Data, conversationId: UUID) async throws {
        try await gqlStore.updateCache(
            for: Constants.rootQuery(conversationId: conversationId),
            onlyIfExists: true
        ) { [logger](cache: inout GQL.GetConversationItemsQuery.Data) in
            let existingIds = Set(cache.conversation.conversation.items.data.compactMap {
                $0?.fragments.conversationItemFragment.id
            })
            let newItems = data.conversation.conversation.items.data.filter { maybeItem in
                guard let item = maybeItem else { return false }
                guard let itemId = item.fragments.conversationItemFragment.id else {
                    logger.warning(message: "Unknown item type", extra: ["type": item.__typename])
                    return false
                }
                if existingIds.contains(itemId) {
                    logger.warning(message: "Found duplicated item when loading more", extra: ["item": item])
                    return false
                }
                return true
            }
            cache.conversation.conversation.items.data.append(contentsOf: newItems)
            cache.conversation.conversation.items.hasMore = data.conversation.conversation.items.hasMore
            cache.conversation.conversation.items.nextCursor = data.conversation.conversation.items.nextCursor
        }
    }
}

private extension GQL.ConversationItemFragment {
    init(message: GQL.MessageFragment) {
        self.init(unsafeResultMap: message.resultMap)
    }
    
    init(conversationActivity: GQL.ConversationActivityFragment) {
        self.init(unsafeResultMap: conversationActivity.resultMap)
    }
}
