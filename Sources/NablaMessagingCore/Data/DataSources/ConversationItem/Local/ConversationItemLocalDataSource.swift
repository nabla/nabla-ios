import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationItemLocalDataSource {
    func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem]
    
    func getConversationItem(withClientId clientId: UUID) -> LocalConversationItem?
    
    func watchConversationItems(ofConversationWithId conversationId: UUID) -> AnyPublisher<[LocalConversationItem], Never>
    
    func addConversationItem(_ conversationItem: LocalConversationItem)
    
    func updateConversationItem(_ conversationItem: LocalConversationItem)
    func updateConversationItems(_ conversationItems: [LocalConversationItem])
    
    func removeConversationItem(withClientId clientId: UUID)
}
