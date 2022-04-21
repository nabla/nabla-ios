import Foundation

enum RemoteConversationItemTransformer {
    static func transform(_ remoteConversationItem: RemoteConversationItem) -> ConversationItem? {
        let message = remoteConversationItem.fragments.messageFragment
        let sender: ConversationItemSender

        if let provider = message.author?.asProvider?.fragments.providerFragment {
            sender = .provider(id: provider.id, avatarURL: provider.avatarUrl?.fragments.ephemeralUrlFragment.url)
        } else if message.author?.asPatient != nil {
            sender = .patient
        } else {
            // This is a temporary fix, backend should stop using an optional `sender`
            // TODO: @tgy remove workaround
            sender = .provider(id: .init(), avatarURL: nil)
        }

        if let textContent = message.content?.asTextMessageContent?.fragments.textMessageContentFragment {
            return TextMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: sender,
                state: .sent,
                content: textContent.text
            )
        }
        assertionFailure("Unknown remote conversation item content \(String(describing: message.content))")
        return nil
    }
}
