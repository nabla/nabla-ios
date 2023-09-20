import Foundation

enum ConversationTransformer {
    // MARK: - Internal
    
    static func transform(
        data: RemoteConversationList,
        conversationItemTranformer: RemoteConversationItemTransformer
    ) -> [Conversation] {
        data.conversations.conversations
            .map { conversation in
                transform(
                    fragment: conversation.fragments.conversationFragment,
                    conversationItemTransformer: conversationItemTranformer
                )
            }
            .sorted { $0.lastModified > $1.lastModified }
    }
    
    static func transform(
        fragment: RemoteConversation,
        conversationItemTransformer: RemoteConversationItemTransformer
    ) -> Conversation {
        let lastMessage = fragment.lastMessage.map {
            conversationItemTransformer.transform($0.fragments.messageFragment)
        } as? ConversationMessage
        
        return Conversation(
            id: fragment.id,
            title: fragment.title,
            subtitle: fragment.subtitle,
            inboxPreviewTitle: fragment.inboxPreviewTitle,
            lastMessagePreview: fragment.lastMessagePreview,
            lastMessage: lastMessage,
            lastModified: fragment.updatedAt,
            patientUnreadMessageCount: fragment.unreadMessageCount,
            pictureUrl: URL(string: fragment.pictureUrl?.fragments.ephemeralUrlFragment.url),
            providers: transform(providers: fragment.providers),
            isLocked: fragment.isLocked,
            isLocalOnly: false
        )
    }
    
    static func transform(conversation: LocalConversation) -> Conversation {
        Conversation(
            id: conversation.id,
            title: conversation.title,
            subtitle: nil,
            inboxPreviewTitle: conversation.title ?? L10n.draftConversationDefaultTitle,
            lastMessagePreview: nil,
            lastMessage: nil,
            lastModified: conversation.creationDate,
            patientUnreadMessageCount: 0,
            pictureUrl: nil,
            providers: [],
            isLocked: false,
            isLocalOnly: conversation.remoteId == nil
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
