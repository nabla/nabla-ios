import Foundation

enum RemoteConversationItemTransformer {
    static func transform(_ remoteConversationItem: RemoteConversationItem) -> ConversationItem? {
        let message = remoteConversationItem.fragments.messageFragment
        let sender: ConversationItemSender

        if let provider = message.author.asProvider?.fragments.providerFragment {
            sender = .provider(.init(id: provider.id, avatarURL: provider.avatarUrl?.fragments.ephemeralUrlFragment.url))
        } else if message.author.asPatient != nil {
            sender = .patient
        } else {
            // This is a temporary fix, backend should stop using an optional `sender`
            // TODO: @tgy remove workaround
            sender = .provider(.init(id: .init(), avatarURL: nil))
        }

        let messageContentFragment = message.content?.fragments.messageContentFragment
        if let textContent = messageContentFragment?.asTextMessageContent?.fragments.textMessageContentFragment {
            return TextMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: sender,
                state: .sent,
                content: textContent.text
            )
        } else if messageContentFragment?.asDeletedMessageContent != nil {
            return DeleteMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: sender,
                state: .sent
            )
        }
        assertionFailure("Unknown remote conversation item content \(String(describing: message.content))")
        return nil
    }
}
