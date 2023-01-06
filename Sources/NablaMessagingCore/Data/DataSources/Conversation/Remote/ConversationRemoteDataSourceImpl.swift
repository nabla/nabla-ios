import Combine
import Foundation
import NablaCore

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
    
    func createConversation(message: GQL.SendMessageInput?, title: String?, providerIds: [UUID]?) async throws -> RemoteConversation {
        let response = try await gqlClient.perform(
            mutation: GQL.CreateConversationMutation(
                title: title,
                providerIds: providerIds,
                initialMessage: message
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
    
    func watchConversation(_ conversationId: UUID) -> AnyPublisher<RemoteConversation, GQLError> {
        gqlClient.watch(
            query: GQL.GetConversationQuery(id: conversationId),
            policy: .returnCacheDataAndFetch
        )
        .map(\.conversation.conversation.fragments.conversationFragment)
        .eraseToAnyPublisher()
    }
    
    func watchConversations() -> AnyPublisher<PaginatedList<RemoteConversation>, GQLError> {
        let watcher = gqlClient.watch(
            query: Constants.conversationsRootQuery,
            policy: .fetchIgnoringCacheData
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
            .map { data in
                let sortedConversations = data.conversations.conversations
                    .map(\.fragments.conversationFragment)
                    .nabla.sorted(\.updatedAt, using: >)
                return PaginatedList(
                    elements: sortedConversations,
                    loadMore: data.conversations.hasMore ? makeLoadMore(data.conversations.nextCursor) : nil
                )
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
        static let conversationsRootQuery = conversationsQuery(forCursor: nil)
        static func conversationsQuery(forCursor cursor: String??) -> GQL.GetConversationsQuery {
            GQL.GetConversationsQuery(page: .init(cursor: cursor, numberOfItems: numberOfItemsPerPage))
        }
    }
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    
    private func handleConversationsEvent(_ event: RemoteConversationsEvent) async throws {
        if let conversationCreatedEvent = event.asConversationCreatedEvent {
            try await appendToCache(
                conversation: conversationCreatedEvent.conversation.fragments.conversationFragment
            )
        } else if let conversationDeletedEvent = event.asConversationDeletedEvent {
            try await removeFromCache(conversationId: conversationDeletedEvent.conversationId)
        }
    }
    
    private func appendToCache(conversation: GQL.ConversationFragment) async throws {
        try await gqlStore.updateCache(
            for: Constants.conversationsRootQuery,
            onlyIfExists: true,
            body: { cache in
                let alreadyInCache = cache.conversations.conversations
                    .contains { existingConversation in
                        existingConversation.fragments.conversationFragment.id == conversation.id
                    }
                
                if alreadyInCache {
                    return
                }
                
                cache.conversations.conversations.insert(.init(unsafeResultMap: conversation.resultMap), at: 0)
            }
        )
    }
    
    private func removeFromCache(conversationId: UUID) async throws {
        try await gqlStore.updateCache(
            for: Constants.conversationsRootQuery,
            onlyIfExists: true,
            body: { cache in
                cache.conversations.conversations.removeAll(where: { $0.fragments.conversationFragment.id == conversationId })
            }
        )
    }
    
    private func handleLoadMoreConversations(data: RemoteConversationList) async throws {
        try await gqlStore.updateCache(
            for: Constants.conversationsRootQuery,
            onlyIfExists: true
        ) { (cache: inout RemoteConversationList) in
            cache.conversations.conversations.append(contentsOf: data.conversations.conversations)
            cache.conversations.hasMore = data.conversations.hasMore
            cache.conversations.nextCursor = data.conversations.nextCursor
        }
    }
}
