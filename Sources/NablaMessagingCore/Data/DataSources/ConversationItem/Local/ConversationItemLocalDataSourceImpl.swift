import Foundation
#if canImport(NablaUtils)
    import NablaUtils
#endif

private enum Constants {
    static let localItemsDidChangeNotification = Notification.Name(rawValue: "com.nabla.localConversationItemsDidChangeNotification")
    static let updatedConversationIdKey = "updatedConversationIdKey"
}

class ConversationItemLocalDataSourceImpl: ConversationItemLocalDataSource {
    // MARK: - Internal
    
    func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem] {
        conversationItems[conversationId] ?? []
    }
    
    func getConversationItem(withClientId clientId: UUID, inConversationWithId conversationId: UUID) -> LocalConversationItem? {
        conversationItems[conversationId]?.first { $0.clientId == clientId }
    }
    
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping ([LocalConversationItem]) -> Void
    ) -> Cancellable {
        LocalDataSourceWatcher(localDataSource: self, conversationId: conversationId, callback: callback)
    }
    
    func addConversationItem(
        _ conversationItem: LocalConversationItem,
        toConversationWithId conversationId: UUID
    ) {
        var items = conversationItems[conversationId] ?? []
        items.append(conversationItem)
        items.sort(\.date)
        conversationItems[conversationId] = items
        notifyChange(forConversationWithId: conversationId)
    }
    
    func updateConversationItem(
        _ conversationItem: LocalConversationItem,
        inConversationWithId conversationId: UUID
    ) {
        var items = conversationItems[conversationId] ?? []
        guard let index = items.firstIndex(where: { $0.clientId == conversationItem.clientId }) else { return }
        items[index] = conversationItem
        items.sort(\.date)
        conversationItems[conversationId] = items
        notifyChange(forConversationWithId: conversationId)
    }
    
    // MARK: - Private
    
    private var conversationItems = [UUID: [LocalConversationItem]]()
    
    private func notifyChange(forConversationWithId conversationId: UUID) {
        NotificationCenter.default.post(
            name: Constants.localItemsDidChangeNotification,
            object: nil,
            userInfo: [
                Constants.updatedConversationIdKey: conversationId,
            ]
        )
    }
}

private class LocalDataSourceWatcher: Cancellable {
    // MARK: - Internal
    
    func cancel() {
        NotificationCenter.default.removeObserver(
            self,
            name: Constants.localItemsDidChangeNotification,
            object: nil
        )
    }
    
    init(
        localDataSource: ConversationItemLocalDataSource,
        conversationId: UUID,
        callback: @escaping ([LocalConversationItem]) -> Void
    ) {
        self.localDataSource = localDataSource
        self.conversationId = conversationId
        self.callback = callback
        observeUpdates()
        notifyNewValues()
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    private let localDataSource: ConversationItemLocalDataSource
    
    private let conversationId: UUID
    private let callback: ([LocalConversationItem]) -> Void
    
    private func observeUpdates() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(localDataSourceDidChangeNotificationHandler),
            name: Constants.localItemsDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func localDataSourceDidChangeNotificationHandler(_ notification: Notification) {
        guard
            let updatedConversationId = notification.userInfo?[Constants.updatedConversationIdKey] as? UUID,
            updatedConversationId == conversationId
        else { return }
        notifyNewValues()
    }
    
    private func notifyNewValues() {
        let items = localDataSource.getConversationItems(ofConversationWithId: conversationId)
        callback(items)
    }
}
