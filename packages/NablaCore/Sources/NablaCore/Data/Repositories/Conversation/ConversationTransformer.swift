import Foundation

enum ConversationTransformer {
    static func transform(data: RemoteConversationList) -> [Conversation] {
        data.conversations.conversations.map { conversation in
            transform(fragment: conversation.fragments.conversationFragment)
        }
    }
    
    static func transform(fragment: RemoteConversation) -> Conversation {
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
