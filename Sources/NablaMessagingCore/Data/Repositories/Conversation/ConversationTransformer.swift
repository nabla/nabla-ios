import Foundation

enum ConversationTransformer {
    // MARK: - Internal
    
    static func transform(data: RemoteConversationList) -> [Conversation] {
        data.conversations.conversations
            .map { conversation in
                transform(fragment: conversation.fragments.conversationFragment)
            }
            .sorted { $0.lastModified > $1.lastModified }
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
            pictureUrl: URL(string: fragment.pictureUrl?.fragments.ephemeralUrlFragment.url),
            providers: transform(providers: fragment.providers),
            isLocked: fragment.isLocked
        )
    }
    
    static func transform(conversation: LocalConversation) -> Conversation {
        Conversation(
            id: conversation.id,
            title: conversation.title,
            subtitle: nil,
            inboxPreviewTitle: conversation.title ?? L10n.draftConversationDefaultTitle,
            lastMessagePreview: nil,
            lastModified: conversation.creationDate,
            patientUnreadMessageCount: 0,
            pictureUrl: nil,
            providers: [],
            isLocked: false
        )
    }
    
    // MARK: - Private
    
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
