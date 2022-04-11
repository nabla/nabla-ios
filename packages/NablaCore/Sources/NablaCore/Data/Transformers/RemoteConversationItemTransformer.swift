import Foundation

enum RemoteConversationItemTransformer {
    static func transform(_ remoteConversationItem: RemoteConversationItem) -> ConversationItem? {
        let message = remoteConversationItem.fragments.messageFragment
        if let textContent = message.content?.asTextMessageContent?.fragments.textMessageContentFragment {
            return TextMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: .system, // TODO: Parse sender
                state: .sent,
                content: textContent.text
            )
        }
        assertionFailure("Unknown remote conversation item content \(String(describing: message.content))")
        return nil
    }
}
