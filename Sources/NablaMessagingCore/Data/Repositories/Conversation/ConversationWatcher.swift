import Foundation
import NablaCore

final class ConversationWatcher: Watcher {
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
