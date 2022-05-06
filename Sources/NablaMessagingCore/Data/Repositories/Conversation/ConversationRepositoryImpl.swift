import Foundation
import NablaUtils

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Internal
    
    func watchConversation(
        _ conversationId: UUID,
        callback: @escaping (Result<Conversation, Error>) -> Void
    ) -> Cancellable {
        let watcher = remoteDataSource.watchConversation(conversationId, callback: { [weak self] result in
            switch result {
            case let .failure(error):
                callback(.failure(error))
            case let .success(data):
                let conversation = ConversationTransformer.transform(fragment: data)
                if conversation.providers.contains(where: \.isTyping) {
                    self?.remoteTypingDebouncer.execute {
                        callback(.success(conversation))
                    }
                } else {
                    self?.remoteTypingDebouncer.cancel()
                }
                callback(.success(conversation))
            }
        })
        
        return watcher
    }
    
    func watchConversations(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        let watcher = remoteDataSource.watchConversations { result in
            switch result {
            case let .failure(error):
                callback(.failure(error))
            case let .success(data):
                let model = ConversationList(
                    conversations: ConversationTransformer.transform(data: data),
                    hasMore: data.conversations.hasMore
                )
                callback(.success(model))
            }
        }
        
        let holder = PaginatedWatcherAndSubscriptionHolder(watcher: watcher)
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription()
        holder.hold(eventsSubscription)
        
        return watcher
    }
    
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        remoteDataSource.createConversation { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(fragment):
                let model = ConversationTransformer.transform(fragment: fragment)
                completion(.success(model))
            }
        }
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
        
        let subscription = remoteDataSource.subscribeToConversationsEvents { _ in }
        conversationsEventsSubscription = subscription
        return subscription
    }
}
