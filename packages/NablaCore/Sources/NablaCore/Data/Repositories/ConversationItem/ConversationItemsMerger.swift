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
    
    func hold(_ cancellables: Cancellable...) {
        otherCancellables.append(contentsOf: cancellables)
    }
    
    func loadMore(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        guard let remoteWatcher = remoteWatcher else {
            fatalError("You should always call `ConversationItemsMerger.resume()` before calling `loadMore(completion:)`.")
        }
        return remoteWatcher.loadMore(completion: completion)
    }
    
    func cancel() {
        localWatcher?.cancel()
        remoteWatcher?.cancel()
        otherCancellables.forEach { $0.cancel() }
    }
    
    init(
        conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
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
    private let callback: (Result<ConversationItems, Error>) -> Void
    
    private var remoteWatcher: PaginatedWatcher?
    private var localWatcher: Cancellable?
    private var otherCancellables = [Cancellable]()
    
    private var remoteData: Result<RemoteConversationWithItems, GQLError>?
    private var localData: [LocalConversationItem]?
    
    private func notifyNewValues() {
        let remoteConversation: RemoteConversationWithItems.Conversation.Conversation
        switch remoteData {
        case .none:
            return // Wait for remote data before emitting any value
        case let .success(remoteData):
            remoteConversation = remoteData.conversation.conversation
        case let .failure(error):
            callback(.failure(error))
            return
        }
        
        let localItems = localData ?? []
        let remoteItems = remoteConversation.items.data.compactMap { $0?.fragments.conversationItemFragment }
        let mergedItems = merge(remoteItems, localItems)
        let newValue = ConversationItems(
            hasMore: remoteConversation.items.hasMore,
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
