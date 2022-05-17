import Foundation
import NablaUtils

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Internal
    
    func watchConversation(
        _ conversationId: UUID,
        handler: ResultHandler<Conversation, NablaWatchConversationError>
    ) -> Cancellable {
        let watcher = remoteDataSource.watchConversation(
            conversationId,
            handler: .init { [weak self] result in
                switch result {
                case let .failure(error):
                    handler(.failure(.technicalError(.init(gqlError: error))))
                case let .success(data):
                    let conversation = ConversationTransformer.transform(fragment: data)
                    if conversation.providers.contains(where: \.isTyping) {
                        self?.remoteTypingDebouncer.execute {
                            handler(.success(conversation))
                        }
                    } else {
                        self?.remoteTypingDebouncer.cancel()
                    }
                    handler(.success(conversation))
                }
            }
        )

        return watcher
    }
    
    func watchConversations(handler: ResultHandler<ConversationList, NablaWatchConversationsError>) -> PaginatedWatcher {
        let watcher = remoteDataSource.watchConversations(handler: .init { result in
            switch result {
            case let .failure(error):
                handler(.failure(.technicalError(.init(gqlError: error))))
            case let .success(data):
                let model = ConversationList(
                    conversations: ConversationTransformer.transform(data: data),
                    hasMore: data.conversations.hasMore
                )
                handler(.success(model))
            }
        })

        let holder = PaginatedWatcherAndSubscriptionHolder(watcher: watcher)
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription()
        holder.hold(eventsSubscription)
        
        return watcher
    }
    
    func createConversation(handler: ResultHandler<Conversation, NablaCreateConversationError>) -> Cancellable {
        remoteDataSource.createConversation(
            handler: handler
                .pullbackError { .technicalError(.init(gqlError: $0)) }
                .pullback(ConversationTransformer.transform)
        )
    }
    
    // MARK: - Private
    
    @Inject private var remoteDataSource: ConversationRemoteDataSource
    
    private weak var conversationsEventsSubscription: Cancellable?
    private let remoteTypingDebouncer: Debouncer = .init(
        delay: ProviderInConversation.Constants.typingTimeWindowTimeInterval,
        queue: .global(qos: .userInitiated)
    )
    
    private func makeOrReuseConversationEventsSubscription() -> Cancellable {
        if let subscription = conversationsEventsSubscription {
            return subscription
        }
        
        let subscription = remoteDataSource.subscribeToConversationsEvents(handler: .void)
        conversationsEventsSubscription = subscription
        return subscription
    }
}
