import Foundation

enum LocalConversationItemTransformer {
    static func transform(_ localConversationItem: LocalConversationItem) -> ConversationItem? {
        if let textMessageItem = localConversationItem as? LocalTextMessageItem {
            return TextMessageItem(
                id: textMessageItem.id,
                date: textMessageItem.date,
                sender: textMessageItem.sender,
                state: textMessageItem.state,
                content: textMessageItem.content
            )
        }
        assertionFailure("Unknown local conversation item \(localConversationItem)")
        return nil
    }
}
