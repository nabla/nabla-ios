import Foundation
import NablaUtils

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Internal
    
    func watch(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
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
    
    private func makeOrReuseConversationEventsSubscription() -> Cancellable {
        if let subscription = conversationsEventsSubscription {
            return subscription
        }
        
        let subscription = remoteDataSource.subscribeToConversationsEvents { _ in }
        conversationsEventsSubscription = subscription
        return subscription
    }
}