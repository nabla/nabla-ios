import Foundation
import NablaCore
#if canImport(NablaUtils)
    import NablaUtils
#endif

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Initializer

    init(
        remoteDataSource: ConversationRemoteDataSource,
        localDataSource: ConversationLocalDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    // MARK: - Internal
    
    func getConversationTransientId(from id: UUID) -> TransientUUID {
        if let localConversation = localDataSource.getConversation(withId: id) {
            return TransientUUID(localId: localConversation.id, remoteId: localConversation.remoteId)
        } else {
            return TransientUUID(remoteId: id)
        }
    }
    
    func watchConversation(
        withId conversationId: TransientUUID,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Watcher {
        ConversationWatcher(
            conversationId: conversationId,
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            handler: .init { [weak self] result in
                switch result {
                case let .failure(error):
                    handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
                case let .success(conversation):
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
    }
    
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher {
        let watcher = remoteDataSource.watchConversations(handler: .init { result in
            switch result {
            case let .failure(error):
                handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
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
        
        return holder
    }
    
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: GQL.SendMessageInput?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable {
        remoteDataSource.createConversation(
            title: title,
            providerIds: providerIds,
            initialMessage: initialMessage,
            handler: handler
                .pullbackError { error in
                    switch error {
                    case let .entityNotFound(message):
                        return ProviderNotFoundError(message: message)
                    case let .permissionRequired(message):
                        return ProviderMissingPermissionError(message: message)
                    default:
                        return GQLErrorTransformer.transform(gqlError: error)
                    }
                }
                .pullback(ConversationTransformer.transform)
        )
    }
    
    func createDraftConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation {
        let localConversation = localDataSource.createConversation(title: title, providerIds: providerIds)
        return ConversationTransformer.transform(conversation: localConversation)
    }
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard let remoteId = conversationId.remoteId else { return Failure() }
        
        return remoteDataSource.setIsTyping(
            isTyping,
            conversationId: remoteId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
    }
    
    func markConversationAsSeen(conversationId: TransientUUID, handler: ResultHandler<Void, NablaError>) -> Cancellable {
        guard let remoteId = conversationId.remoteId else { return Failure() }
        
        return remoteDataSource.markConversationAsSeen(
            conversationId: remoteId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
    }
    
    // MARK: - Private
    
    private let remoteDataSource: ConversationRemoteDataSource
    private let localDataSource: ConversationLocalDataSource

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

private final class ConversationWatcher: Watcher {
    // MARK: - Internal
    
    func refetch() {
        remoteWatcher?.refetch()
    }
    
    func cancel() {
        localWatcher?.cancel()
        remoteWatcher?.cancel()
        remoteIdObserver?.cancel()
    }
    
    init(
        conversationId: TransientUUID,
        localDataSource: ConversationLocalDataSource,
        remoteDataSource: ConversationRemoteDataSource,
        handler: ResultHandler<Conversation, GQLError>
    ) {
        self.conversationId = conversationId
        self.handler = handler
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        
        if let remoteId = conversationId.remoteId {
            observeRemoteData(remoteId: remoteId)
        } else {
            observeLocalData(localId: conversationId.localId)
            
            remoteIdObserver = conversationId.observeRemoteId { [weak self] remoteId in
                self?.observeRemoteData(remoteId: remoteId)
            }
        }
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private let conversationId: TransientUUID
    private let handler: ResultHandler<Conversation, GQLError>
    private let localDataSource: ConversationLocalDataSource
    private let remoteDataSource: ConversationRemoteDataSource
    
    private var localWatcher: Cancellable?
    private var remoteIdObserver: Cancellable?
    private var remoteWatcher: Watcher?
    
    private var remoteConversationResult: Result<RemoteConversation, GQLError>?
    private var localConversation: LocalConversation?
    
    private func observeLocalData(localId: UUID) {
        localWatcher = localDataSource.watchConversation(localId) { [weak self] localConversation in
            self?.localConversation = localConversation
            self?.notifyChange()
        }
    }
    
    private func observeRemoteData(remoteId: UUID) {
        remoteWatcher = remoteDataSource.watchConversation(
            remoteId,
            handler: .init { [weak self] result in
                self?.remoteConversationResult = result
                self?.notifyChange()
            }
        )
    }
    
    private func notifyChange() {
        if let remoteConversationResult = remoteConversationResult {
            switch remoteConversationResult {
            case let .failure(error): handler(.failure(error))
            case let .success(conversation): handler(.success(ConversationTransformer.transform(fragment: conversation)))
            }
        } else if let localConversation = localConversation {
            handler(.success(ConversationTransformer.transform(conversation: localConversation)))
        }
    }
}
