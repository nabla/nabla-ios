import Foundation
import NablaUtils

class ConversationItemRemoteDataSourceImpl: ConversationItemRemoteDataSource {
    // MARK: - Internal
    
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<RemoteConversationWithItems, GQLError>) -> Void
    ) -> PaginatedWatcher {
        ConversationItemsWatcher(
            conversationId: conversationId,
            numberOfItemsPerPage: 50,
            callback: callback
        )
    }

    func send(
        localMessageClientId: UUID,
        remoteMessageInput: GQL.SendMessageContentInput,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.SendMessageMutation(
                conversationId: conversationId,
                content: remoteMessageInput,
                clientId: localMessageClientId
            ),
            completion: { result in
                callback(result.map { _ in () }.mapError { $0 as Error })
            }
        )
    }

    func delete(messageId: UUID, callback: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.DeleteMessageMutation(messageId: messageId),
            completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error): callback(.failure(error))
                case .success: callback(.success(()))
                }
            }
        )
    }

    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<RemoteConversationEvent, GQLError>) -> Void
    ) -> Cancellable {
        gqlClient.subscribe(subscription: GQL.ConversationEventsSubscription(id: conversationId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                callback(.failure(error))
            case let .success(data):
                guard let event = data.conversation?.event else { return }
                self.handleConversationEvent(event, inConversationWithId: conversationId)
                callback(.success(event))
            }
        }
    }

    func setIsTyping(_ isTyping: Bool, conversationId: UUID) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.SetTypingMutation(conversationId: conversationId, isTyping: isTyping),
            completion: { _ in }
        )
    }

    func markConversationAsSeen(conversationId: UUID) -> Cancellable {
        gqlClient.perform(
            mutation: GQL.MaskAsSeenMutation(conversationId: conversationId),
            completion: { _ in }
        )
    }

    // MARK: - Private
    
    @Inject private var gqlClient: GQLClient
    @Inject private var gqlStore: GQLStore
    
    private enum Constants {
        static func rootQuery(conversationId: UUID) -> GQL.GetConversationItemsQuery {
            .init(id: conversationId, page: .init(cursor: nil, numberOfItems: 50))
        }
    }
    
    private func handleConversationEvent(_ event: GQL.ConversationEventsSubscription.Data.Conversation.Event, inConversationWithId conversationId: UUID) {
        if let messageCreatedEvent = event.asMessageCreatedEvent {
            append(
                message: messageCreatedEvent.message.fragments.messageFragment,
                toCacheOfConversationWithId: conversationId
            )
        } else if let messageUpdatedEvent = event.asMessageUpdatedEvent {
            update(
                message: messageUpdatedEvent.message.fragments.messageFragment,
                toCacheOfConversationWithId: conversationId
            )
        }
    }
    
    private func append(message: GQL.MessageFragment, toCacheOfConversationWithId conversationId: UUID) {
        gqlStore.updateCache(
            for: Constants.rootQuery(conversationId: conversationId),
            onlyIfExists: true,
            body: { cache in
                cache.conversation.conversation.items.data.append(.init(unsafeResultMap: message.resultMap))
            },
            completion: { _ in }
        )
    }
    
    private func update(message: GQL.MessageFragment, toCacheOfConversationWithId _: UUID) {
        gqlStore.updateCache(
            of: message,
            onlyIfExists: true,
            body: { cache in
                cache = message
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
    init(
        conversationId: UUID,
        numberOfItemsPerPage: Int?,
        callback: @escaping (Result<RemoteConversationWithItems, GQLError>) -> Void
    ) {
        self.conversationId = conversationId
        super.init(
            numberOfItemsPerPage: numberOfItemsPerPage,
            callback: callback
        )
    }

    override func makeQuery(page: GQL.OpaqueCursorPage) -> GQL.GetConversationItemsQuery {
        GQL.GetConversationItemsQuery(id: conversationId, page: page)
    }
    
    override func updateCache(_ cache: inout RemoteConversationWithItems, withAdditionalData data: RemoteConversationWithItems) {
        cache.conversation.conversation.items.data.append(contentsOf: data.conversation.conversation.items.data)
        cache.conversation.conversation.items.hasMore = data.conversation.conversation.items.hasMore
        cache.conversation.conversation.items.nextCursor = data.conversation.conversation.items.nextCursor
    }
    
    // MARK: - Private
    
    private let conversationId: UUID
}
