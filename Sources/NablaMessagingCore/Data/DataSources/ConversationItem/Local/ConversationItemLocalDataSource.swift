import Foundation
import NablaCore

protocol ConversationItemLocalDataSource {
    func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem]
    
    func getConversationItem(
        withClientId clientId: UUID,
        inConversationWithId conversationId: UUID
    ) -> LocalConversationItem?
    
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping ([LocalConversationItem]) -> Void
    ) -> Cancellable
    
    func addConversationItem(
        _ conversationItem: LocalConversationItem,
        toConversationWithId conversationId: UUID
    )
    
    func updateConversationItem(
        _ conversationItem: LocalConversationItem,
        inConversationWithId conversationId: UUID
    )
}
