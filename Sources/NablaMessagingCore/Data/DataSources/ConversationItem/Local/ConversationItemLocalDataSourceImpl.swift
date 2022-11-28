import Combine
import Foundation
import NablaCore

class ConversationItemLocalDataSourceImpl: ConversationItemLocalDataSource {
    // MARK: - Internal
    
    func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem] {
        storage(forConversationWithId: conversationId)
            .value
            .values
            .nabla.sorted(\LocalConversationItem.date)
    }
    
    func getConversationItem(withClientId clientId: UUID) -> LocalConversationItem? {
        for conversationStorage in storage.value.values {
            if let item = conversationStorage.value[clientId] {
                return item
            }
        }
        return nil
    }
    
    func watchConversationItems(ofConversationWithId conversationId: UUID) -> AnyPublisher<[LocalConversationItem], Never> {
        storage(forConversationWithId: conversationId)
            .map { conversationStorage in
                conversationStorage.values.nabla.sorted(\LocalConversationItem.date)
            }
            .eraseToAnyPublisher()
    }
    
    func addConversationItem(
        _ conversationItem: LocalConversationItem
    ) {
        storage(forConversationWithId: conversationItem.conversationId).value[conversationItem.clientId] = conversationItem
    }
    
    func updateConversationItem(
        _ conversationItem: LocalConversationItem
    ) {
        updateConversationItems([conversationItem])
    }
    
    func updateConversationItems(
        _ conversationItems: [LocalConversationItem]
    ) {
        let itemsPerConversations = conversationItems.nabla.toGroups(\.conversationId)
        for (conversationId, items) in itemsPerConversations {
            updateConversationItems(items, inConversationWithId: conversationId)
        }
    }
    
    func removeConversationItem(
        withClientId clientId: UUID
    ) {
        for conversationStorage in storage.value.values {
            if conversationStorage.value[clientId] != nil {
                conversationStorage.value.removeValue(forKey: clientId)
            }
        }
    }
    
    // MARK: - Private
    
    private typealias ConversationStorage = CurrentValueSubject<[UUID: LocalConversationItem], Never>
    private typealias GlobalStorage = CurrentValueSubject<[UUID: ConversationStorage], Never>
    
    private let storage = GlobalStorage([:])
    
    private func storage(forConversationWithId conversationId: UUID) -> ConversationStorage {
        if let conversationStorage = storage.value[conversationId] {
            return conversationStorage
        }
        let conversationStorage = ConversationStorage([:])
        storage.value[conversationId] = conversationStorage
        return conversationStorage
    }
    
    private func updateConversationItems(
        _ conversationItems: [LocalConversationItem],
        inConversationWithId conversationId: UUID
    ) {
        let conversationStorage = storage(forConversationWithId: conversationId)
        var updatedItems = conversationStorage.value
        for item in conversationItems {
            updatedItems[item.clientId] = item
        }
        conversationStorage.send(updatedItems)
    }
}
