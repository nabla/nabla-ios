import Foundation
import NablaCore

private enum Constants {
    static let localConversationsDidChangeNotification = Notification.Name("localConversationsDidChangeNotification")
    static let updatedConversationIdKey = "updatedConversationId"
}

final class ConversationLocalDataSourceImpl: ConversationLocalDataSource {
    // MARK: - Internal
    
    func getConversation(withId id: UUID) -> LocalConversation? {
        conversations[id]
    }
    
    func createConversation(title: String?, providerIds: [UUID]?) -> LocalConversation {
        let conversation = LocalConversation(
            id: .init(),
            remoteId: nil,
            creationDate: .init(),
            title: title,
            providerIds: providerIds
        )
        conversations[conversation.id] = conversation
        return conversation
    }
    
    func updateConversation(
        _ conversation: LocalConversation
    ) {
        conversations[conversation.id] = conversation
        notifyChange(forConversationWithId: conversation.id)
    }
    
    func watchConversation(_ conversationId: UUID, callback: @escaping (LocalConversation) -> Void) -> Cancellable {
        LocalDataSourceWatcher(localDataSource: self, conversationId: conversationId, callback: callback)
    }
    
    // MARK: - Private
    
    private var conversations: [UUID: LocalConversation] = [:]
    
    private func notifyChange(forConversationWithId conversationId: UUID) {
        NotificationCenter.default.post(
            name: Constants.localConversationsDidChangeNotification,
            object: nil,
            userInfo: [
                Constants.updatedConversationIdKey: conversationId,
            ]
        )
    }
}

private final class LocalDataSourceWatcher: Cancellable {
    // MARK: - Internal
    
    func cancel() {
        NotificationCenter.default.removeObserver(
            self,
            name: Constants.localConversationsDidChangeNotification,
            object: nil
        )
    }
    
    init(
        localDataSource: ConversationLocalDataSource,
        conversationId: UUID,
        callback: @escaping (LocalConversation) -> Void
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
    
    private let localDataSource: ConversationLocalDataSource
    
    private let conversationId: UUID
    private let callback: (LocalConversation) -> Void
    
    private func observeUpdates() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(localDataSourceDidChangeNotificationHandler),
            name: Constants.localConversationsDidChangeNotification,
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
        guard let conversation = localDataSource.getConversation(withId: conversationId) else { return }
        callback(conversation)
    }
}
