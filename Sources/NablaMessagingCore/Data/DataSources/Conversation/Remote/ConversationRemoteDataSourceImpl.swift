import Combine
import Foundation
import NablaCore

final class ConversationRemoteDataSourceImpl: ConversationRemoteDataSource {
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
    
    func createConversation(message: GQL.SendMessageInput?, title: String?, providerIds: [UUID]?) async throws -> RemoteConversation {
        let response = try await gqlClient.perform(
            mutation: GQL.CreateConversationMutation(
                title: title.nabla.asGQLNullable(),
                providerIds: providerIds.nabla.asGQLNullable(),
                initialMessage: message.nabla.asGQLNullable()
            )
        )
        let conversation = response.createConversation.conversation.fragments.conversationFragment
        try await appendToCache(conversation: conversation)
        return conversation
    }
    
    func setIsTyping(_ isTyping: Bool, conversationId: UUID) async throws {
        _ = try await gqlClient.perform(
            mutation: GQL.SetTypingMutation(conversationId: conversationId, isTyping: isTyping)
        )
    }
    
    func markConversationAsSeen(conversationId: UUID) async throws {
        _ = try await gqlClient.perform(mutation: GQL.MaskAsSeenMutation(conversationId: conversationId))
    }
    
    func watchConversation(_ conversationId: UUID) -> AnyPublisher<AnyResponse<RemoteConversation, GQLError>, GQLError> {
        gqlClient.watchAndUpdate(
            query: GQL.GetConversationQuery(id: conversationId)
        )
        .map { response in
            response.mapData(\.conversation.conversation.fragments.conversationFragment)
        }
        .eraseToAnyPublisher()
    }
    
    func watchConversations() -> AnyPublisher<AnyResponse<PaginatedList<RemoteConversation>, GQLError>, GQLError> {
        let watcher = gqlClient.watchAndUpdate(
            query: Constants.conversationsRootQuery
        )
        
        let makeLoadMore: (String?) -> () async throws -> Void = { [weak self] cursor in
            {
                guard let self = self else { return }
                let response = try await self.gqlClient.fetch(
                    query: Constants.conversationsQuery(forCursor: cursor),
                    policy: .fetchIgnoringCacheCompletely
                )
                try await self.handleLoadMoreConversations(data: response)
            }
        }
        
        return watcher
            .map { response in
                response.mapData { data in
                    let sortedConversations = data.conversations.conversations
                        .map(\.fragments.conversationFragment)
                        .nabla.sorted(\.updatedAt, using: >)
                    return PaginatedList(
                        elements: sortedConversations,
                        loadMore: data.conversations.hasMore ? makeLoadMore(data.conversations.nextCursor) : nil
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func subscribeToConversationsEvents() -> AnyPublisher<RemoteConversationsEvent, Never> {
        gqlClient.subscribe(subscription: GQL.ConversationsEventsSubscription())
            .compactMap { $0.conversations?.event }
            .handleEvents(receiveOutput: { event in
                Task { [weak self] in
                    try await self?.handleConversationsEvent(event)
                }
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let numberOfItemsPerPage = 50
        static let conversationsLocalCacheMutation = GQL.GetConversationsLocalCacheMutation(
            page: .init(cursor: .none, numberOfItems: .some(numberOfItemsPerPage))
        )
        static let conversationsRootQuery = conversationsQuery(forCursor: nil)
        static func conversationsQuery(forCursor cursor: String?) -> GQL.GetConversationsQuery {
            GQL.GetConversationsQuery(
                page: .init(
                    cursor: cursor.nabla.asGQLNullable(),
                    numberOfItems: .some(numberOfItemsPerPage)
                )
            )
        }
    }
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    private let logger: Logger
    
    private func handleConversationsEvent(_ event: RemoteConversationsEvent) async throws {
        if let conversationCreatedEvent = event.asConversationCreatedEvent {
            try await appendToCache(
                conversation: conversationCreatedEvent.conversation.fragments.conversationFragment
            )
        } else if let conversationDeletedEvent = event.asConversationDeletedEvent {
            try await removeFromCache(conversationId: conversationDeletedEvent.conversationId)
        } else {
            logger.warning(message: "Unknown conversations event", extra: ["event": event.__typename])
        }
    }
    
    private func appendToCache(conversation: GQL.ConversationFragment) async throws {
        try await gqlStore.updateCache(
            cacheMutation: Constants.conversationsLocalCacheMutation,
            body: { cache in
                let alreadyInCache = cache.conversations.conversations
                    .contains { existingConversation in
                        existingConversation.fragments.conversationFragment.id == conversation.id
                    }
                if alreadyInCache {
                    return
                }
                cache.conversations.conversations.insert(.init(data: conversation.__data), at: 0)
            }
        )
    }
    
    private func removeFromCache(conversationId: UUID) async throws {
        try await gqlStore.updateCache(
            cacheMutation: Constants.conversationsLocalCacheMutation,
            body: { cache in
                cache.conversations.conversations.removeAll { $0.fragments.conversationFragment.id == conversationId }
            }
        )
    }
    
    private func handleLoadMoreConversations(data: RemoteConversationList) async throws {
        try await gqlStore.updateCache(
            cacheMutation: Constants.conversationsLocalCacheMutation,
            body: { cache in
                cache.conversations.conversations.append(
                    contentsOf: data.conversations.conversations.map { .init(data: $0.__data) }
                )
                cache.conversations.hasMore = data.conversations.hasMore
                cache.conversations.nextCursor = data.conversations.nextCursor
            }
        )
    }
}
