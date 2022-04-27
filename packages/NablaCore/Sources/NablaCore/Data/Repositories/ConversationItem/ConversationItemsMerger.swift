import Foundation
import NablaUtils

class ConversationItemsMerger: PaginatedWatcher {
    // MARK: - Internal
    
    func resume() {
        remoteWatcher = remoteDataSource.watchConversationItems(ofConversationWithId: conversationId) { [weak self] result in
            guard let self = self else { return }
            self.remoteData = result
            self.notifyNewValues()
        }
        
        localWatcher = localDataSource.watchConversationItems(ofConversationWithId: conversationId) { [weak self] items in
            guard let self = self else { return }
            self.localData = items
            self.notifyNewValues()
        }
    }
    
    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        guard let remoteWatcher = remoteWatcher else {
            fatalError("You should always call `ConversationItemsMerger.resume()` before calling `loadMore(completion:)`.")
        }
        return remoteWatcher.loadMore(completion: completion)
    }
    
    func loadMore(numberOfItems: Int, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
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
        conversationId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
    ) {
        self.conversationId = conversationId
        self.callback = callback
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    @Inject private var remoteDataSource: ConversationItemRemoteDataSource
    @Inject private var localDataSource: ConversationItemLocalDataSource
    
    private let conversationId: UUID
    private let callback: (Result<ConversationWithItems, Error>) -> Void
    
    private var remoteWatcher: PaginatedWatcher?
    private var localWatcher: Cancellable?
    
    private var remoteData: Result<RemoteConversationWithItems, GQLError>?
    private var localData: [LocalConversationItem]?
    
    private func notifyNewValues() {
        let remoteConversation: RemoteConversationWithItems
        switch remoteData {
        case .none:
            return // Wait for remote data before emitting any value
        case let .success(remoteData):
            remoteConversation = remoteData
        case let .failure(error):
            callback(.failure(error))
            return
        }
        
        let item = remoteConversation.conversation.conversation.items
        let localItems = localData ?? []
        let remoteItems = item.data.compactMap { $0?.fragments.conversationItemFragment }
        let mergedItems = merge(remoteItems, localItems)
        let newValue = ConversationWithItems(
            hasMore: item.hasMore,
            typingProviders: remoteConversation.typingProviders.map(RemoteConversationProviderTransformer.transform),
            items: mergedItems
        )
        callback(.success(newValue))
    }
    
    private func merge(_ remoteItems: [RemoteConversationItem], _ localItems: [LocalConversationItem]) -> [ConversationItem] {
        var localItemsByClientId = localItems.toDictionary(\.clientId)
        
        var mergedItems = remoteItems.compactMap { remoteItem -> ConversationItem? in
            guard let clientId = remoteItem.fragments.messageFragment.clientId else {
                return RemoteConversationItemTransformer.transform(remoteItem)
            }
            if let localItem = localItemsByClientId[clientId] {
                localItemsByClientId.removeValue(forKey: clientId)
                return merge(remoteItem, localItem)
            }
            return RemoteConversationItemTransformer.transform(remoteItem)
        }
        let localOnlyItems = localItemsByClientId.values.compactMap(LocalConversationItemTransformer.transform(_:))
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
