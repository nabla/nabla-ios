import Foundation

protocol ConversationItemLocalDataSource {
    func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem]
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping ([LocalConversationItem]) -> Void
    ) -> Cancellable
    
    func addConversationItem(
        _ conversationItem: LocalConversationItem,
        toConversationWithId conversationId: UUID
    )
}
