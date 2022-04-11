import Foundation
import NablaUtils

class ConversationItemsMerger: Cancellable {
    // MARK: - Internal
    
    func resume() {
        remoteSubscription = remoteDataSource.observeConversationItems(ofConversationWithId: conversationId) { [weak self] result in
            guard let self = self else { return }
            self.remoteData = result
            self.notifyNewValues()
        }
        
        localSubscription = localDataSource.observeConversationItems(ofConversationWithId: conversationId) { [weak self] items in
            guard let self = self else { return }
            self.localData = items
            self.notifyNewValues()
        }
    }
    
    func cancel() {
        localSubscription?.cancel()
        remoteSubscription?.cancel()
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
    
    private var remoteSubscription: Cancellable?
    private var localSubscription: Cancellable?
    
    private var remoteData: Result<GQL.GetConversationItemsQuery.Data, GQLError>?
    private var localData: [LocalConversationItem]?
    
    private func notifyNewValues() {
        let remoteConversation: GQL.GetConversationItemsQuery.Data.Conversation.Conversation
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
        let remoteItems = remoteConversation.items.data.compactMap { $0 }
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
            let clientId = remoteItem.fragments.messageFragment.clientId
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
