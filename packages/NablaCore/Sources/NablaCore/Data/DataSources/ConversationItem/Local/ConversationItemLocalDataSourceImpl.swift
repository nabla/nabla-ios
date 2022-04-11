import Foundation
import NablaUtils

private enum Constants {
    static let localItemsDidChangeNotification = Notification.Name(rawValue: "com.nabla.localConversationItemsDidChangeNotification")
    static let updatedConversationIdKey = "updatedConversationIdKey"
}

class ConversationItemLocalDataSourceImpl: ConversationItemLocalDataSource {
    // MARK: - Internal
    
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping ([LocalConversationItem]) -> Void
    ) -> Cancellable {
        LocalDataSourceWatcher(conversationId: conversationId, callback: callback)
    }
    
    func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem] {
        conversationItems[conversationId] ?? []
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
        conversationId: UUID,
        callback: @escaping ([LocalConversationItem]) -> Void
    ) {
        self.conversationId = conversationId
        self.callback = callback
        observeUpdates()
        notifyNewValues()
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Private
    
    @Inject private var localDataSource: ConversationItemLocalDataSource
    
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
