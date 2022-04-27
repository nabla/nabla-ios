import Foundation

enum LocalConversationItemTransformer {
    static func transform(_ localConversationItem: LocalConversationItem) -> ConversationItem? {
        if let textMessageItem = localConversationItem as? LocalTextMessageItem {
            return TextMessageItem(
                id: textMessageItem.clientId,
                date: textMessageItem.date,
                sender: textMessageItem.sender,
                state: textMessageItem.state,
                content: textMessageItem.content
            )
        } else if let deletedMessageItem = localConversationItem as? LocalDeletedMessageItem {
            return DeleteMessageItem(
                id: deletedMessageItem.clientId,
                date: deletedMessageItem.date,
                sender: deletedMessageItem.sender,
                state: deletedMessageItem.state
            )
        }
        if let imageMessageItem = localConversationItem as? LocalImageMessageItem {
            return ImageMessageItem(
                id: imageMessageItem.clientId,
                date: imageMessageItem.date,
                sender: imageMessageItem.sender,
                state: imageMessageItem.state,
                content: imageMessageItem.content.media
            )
        }
        assertionFailure("Unknown local conversation item \(localConversationItem)")
        return nil
    }
}
