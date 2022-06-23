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
            title: fragment.title,
            subtitle: fragment.subtitle,
            inboxPreviewTitle: fragment.inboxPreviewTitle,
            lastMessagePreview: fragment.lastMessagePreview,
            lastModified: fragment.updatedAt,
            patientUnreadMessageCount: fragment.unreadMessageCount,
            providers: transform(providers: fragment.providers)
        )
    }
    
    private static func transform(providers: [RemoteConversation.Provider]) -> [ProviderInConversation] {
        providers
            .map { provider in
                let providerFragment = provider.fragments.providerInConversationFragment.provider.fragments.providerFragment
                let providerInConversationFragment = provider.fragments.providerInConversationFragment
                
                return ProviderInConversation(
                    provider: RemoteConversationProviderTransformer.transform(provider: providerFragment),
                    typingAt: providerInConversationFragment.typingAt,
                    seenUntil: providerInConversationFragment.seenUntil
                )
            }
    }
}
