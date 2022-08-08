import Foundation
import NablaCore

class ConversationItemsMerger: PaginatedWatcher {
    // MARK: - Internal
    
    func resume() {
        observeLocalData(localId: conversationId.localId)
        
        if let remoteId = conversationId.remoteId {
            observeRemoteData(remoteId: remoteId)
        } else {
            remoteIdObserver = conversationId.observeRemoteId { [weak self] remoteId in
                self?.observeRemoteData(remoteId: remoteId)
            }
        }
    }
    
    func refetch() {
        remoteWatcher?.refetch()
    }
    
    func loadMore(completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        guard let remoteWatcher = remoteWatcher else {
            fatalError("You should always call `ConversationItemsMerger.resume()` before calling `loadMore(completion:)`.")
        }
        return remoteWatcher.loadMore(completion: completion)
    }
    
    func loadMore(numberOfItems: Int, completion: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        guard let remoteWatcher = remoteWatcher else {
            fatalError("You should always call `ConversationItemsMerger.resume()` before calling `loadMore(completion:)`.")
        }
        return remoteWatcher.loadMore(numberOfItems: numberOfItems, completion: completion)
    }
    
    func cancel() {
        localWatcher?.cancel()
        remoteWatcher?.cancel()
        remoteIdObserver?.cancel()
    }
    
    init(
        conversationId: TransientUUID,
        remoteDataSource: ConversationItemRemoteDataSource,
        localDataSource: ConversationItemLocalDataSource,
        handler: ResultHandler<ConversationItems, GQLError>
    ) {
        self.conversationId = conversationId
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.handler = handler
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private let remoteDataSource: ConversationItemRemoteDataSource
    private let localDataSource: ConversationItemLocalDataSource
    
    private let conversationId: TransientUUID
    private let handler: ResultHandler<ConversationItems, GQLError>
    
    private var remoteWatcher: PaginatedWatcher?
    private var localWatcher: Cancellable?
    private var remoteIdObserver: Cancellable?
    
    private var remoteData: Result<RemoteConversationItems, GQLError>?
    private var localData: [LocalConversationItem]?
    
    private func observeLocalData(localId: UUID) {
        localWatcher = localDataSource.watchConversationItems(ofConversationWithId: localId) { [weak self] items in
            guard let self = self else { return }
            self.localData = items
            self.notifyNewValues()
        }
    }
    
    private func observeRemoteData(remoteId: UUID) {
        remoteWatcher = remoteDataSource.watchConversationItems(
            ofConversationWithId: remoteId,
            handler: .init { [weak self] result in
                guard let self = self else { return }
                self.remoteData = result
                self.notifyNewValues()
            }
        )
    }
    
    private func notifyNewValues() {
        let remoteConversation: RemoteConversationItems.Conversation.Conversation?
        switch remoteData {
        case .none:
            remoteConversation = nil
        case let .success(remoteData):
            remoteConversation = remoteData.conversation.conversation
        case let .failure(error):
            handler(.failure(error))
            return
        }
        
        let localItems = localData ?? []
        let remoteItems = remoteConversation?.items.data.compactMap { $0?.fragments.conversationItemFragment } ?? []
        let mergedItems = merge(remoteItems, localItems)
        let newValue = ConversationItems(
            hasMore: remoteConversation?.items.hasMore ?? false,
            items: mergedItems
        )
        handler(.success(newValue))
    }
    
    private func merge(_ remoteItems: [RemoteConversationItem], _ localItems: [LocalConversationItem]) -> [ConversationItem] {
        var localItemsByClientId = localItems.toDictionary(\.clientId)
        
        var mergedItems = remoteItems.compactMap { remoteItem -> ConversationItem? in
            guard let clientId = remoteItem.clientId else {
                return RemoteConversationItemTransformer.transform(remoteItem)
            }
            if let localItem = localItemsByClientId[clientId] {
                localItemsByClientId.removeValue(forKey: clientId)
                return merge(remoteItem, localItem)
            }
            return RemoteConversationItemTransformer.transform(remoteItem)
        }
        let localTransformer = LocalConversationItemTransformer(existingItems: mergedItems)
        let localOnlyItems = localItemsByClientId.values.compactMap(localTransformer.transform(_:))
        mergedItems.append(contentsOf: localOnlyItems)
        mergedItems.sort(\.date, using: >)
        return mergedItems
    }
    
    private func merge(_ remoteItem: RemoteConversationItem, _: LocalConversationItem) -> ConversationItem? {
        // Always use the remote item as source of truth.
        // Come change this when we support editing messages locally.
        RemoteConversationItemTransformer.transform(remoteItem)
    }
}
