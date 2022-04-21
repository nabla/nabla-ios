import Foundation
import NablaUtils

class ConversationItemRemoteDataSourceImpl: ConversationItemRemoteDataSource {
    // MARK: - Internal
    
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<GQL.GetConversationItemsQuery.Data, GQLError>) -> Void
    ) -> Cancellable {
        gqlClient.watch(
            query: Constants.rootQuery(conversationId: conversationId),
            cachePolicy: .returnCacheDataAndFetch,
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
    
    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<GQL.ConversationEventsSubscription.Data, GQLError>) -> Void
    ) -> Cancellable {
        gqlClient.subscribe(subscription: GQL.ConversationEventsSubscription(id: conversationId)) { [weak self] result in
            defer { callback(result) }
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                print(error) // TODO: @tgy
            case let .success(data):
                guard let event = data.conversation?.event else { return }
                self.handleConversationEvent(event, inConversationWithId: conversationId)
            }
        }
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
