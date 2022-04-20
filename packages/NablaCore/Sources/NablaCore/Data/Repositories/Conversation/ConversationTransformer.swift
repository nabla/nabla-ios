import Foundation

enum ConversationTransformer {
    static func transform(fragment: GQL.GetConversationsQuery.Data) -> [Conversation] {
        fragment.conversations.conversations.compactMap { fragment in
            Conversation(
                id: fragment.id,
                avatarURL: fragment.providers.first?.provider.avatarUrl?.url,
                initials: nil,
                title: fragment.title,
                lastMessagePreview: fragment.lastMessagePreview,
                // TODO: (Thibault Tourailles) - Parse real date
                lastUpdatedTime: Date(),
                isUnread: fragment.unreadMessageCount > 0
            )
        }
    }
}
