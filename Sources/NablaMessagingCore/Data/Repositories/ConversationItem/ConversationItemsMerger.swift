import Foundation

class ConversationItemsMerger: PaginatedWatcher {
    // MARK: - Internal
    
    func resume() {
        remoteWatcher = remoteDataSource.watchConversationItems(
            ofConversationWithId: conversationId,
            handler: .init { [weak self] result in
                guard let self = self else {
                    return
                }
                self.remoteData = result
                self.notifyNewValues()
            }
        )

        localWatcher = localDataSource.watchConversationItems(ofConversationWithId: conversationId) { [weak self] items in
            guard let self = self else { return }
            self.localData = items
            self.notifyNewValues()
        }
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
    }
    
    init(
        remoteDataSource: ConversationItemRemoteDataSource,
        localDataSource: ConversationItemLocalDataSource,
        conversationId: UUID,
        handler: ResultHandler<ConversationItems, GQLError>
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.conversationId = conversationId
        self.handler = handler
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private let remoteDataSource: ConversationItemRemoteDataSource
    private let localDataSource: ConversationItemLocalDataSource
    
    private let conversationId: UUID
    private let handler: ResultHandler<ConversationItems, GQLError>
    
    private var remoteWatcher: PaginatedWatcher?
    private var localWatcher: Cancellable?
    
    private var remoteData: Result<RemoteConversationItems, GQLError>?
    private var localData: [LocalConversationItem]?
    
    private func notifyNewValues() {
        let remoteConversation: RemoteConversationItems
        switch remoteData {
        case .none:
            return // Wait for remote data before emitting any value
        case let .success(remoteData):
            remoteConversation = remoteData
        case let .failure(error):
            handler(.failure(error))
            return
        }
        
        let item = remoteConversation.conversation.conversation.items
        let localItems = localData ?? []
        let remoteItems = item.data.compactMap { $0?.fragments.conversationItemFragment }
        let mergedItems = merge(remoteItems, localItems)
        let newValue = ConversationItems(
            conversationId: remoteConversation.conversation.conversation.id,
            hasMore: item.hasMore,
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
        mergedItems.sort(\.date)
        return mergedItems
    }
    
    private func merge(_ remoteItem: RemoteConversationItem, _: LocalConversationItem) -> ConversationItem? {
        // Always use the remote item as source of truth.
        // Come change this when we support editing messages locally.
        RemoteConversationItemTransformer.transform(remoteItem)
    }
}
