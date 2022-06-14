import Foundation

enum RemoteConversationItemTransformer {
    static func transform(_ remoteConversationItem: RemoteConversationItem) -> ConversationItem? {
        if let message = remoteConversationItem.asMessage?.fragments.messageFragment {
            return transform(message)
        }
        if let activity = remoteConversationItem.asConversationActivity?.fragments.conversationActivityFragment {
            return transform(activity)
        }
        assertionFailure("Unknown remote conversation item type: \(remoteConversationItem.__typename)")
        return nil
    }
    
    private static func transform(_ message: GQL.MessageFragment) -> ConversationItem? {
        let messageContentFragment = message.content.fragments.messageContentFragment
        let replyToFragment = message.replyTo?.fragments.replyMessageFragment
        if let textContent = messageContentFragment.asTextMessageContent?.fragments.textMessageContentFragment {
            return TextMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: transform(message.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: transform(replyToFragment),
                content: textContent.text
            )
        } else if messageContentFragment.asDeletedMessageContent != nil {
            return DeletedMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: transform(message.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: transform(replyToFragment)
            )
        } else if
            let imageContent = message.content.fragments.messageContentFragment.asImageMessageContent?.fragments.imageMessageContentFragment,
            let url = URL(string: imageContent.imageFileUpload.url.url),
            let mimeType = MimeType(rawValue: imageContent.imageFileUpload.mimeType) {
            return ImageMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: transform(message.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: transform(replyToFragment),
                content: Media(
                    type: .image,
                    fileName: imageContent.imageFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: url,
                    mimeType: mimeType
                )
            )
        } else if
            let documentContent = message.content.fragments.messageContentFragment.asDocumentMessageContent?.fragments.documentMessageContentFragment,
            let url = URL(string: documentContent.documentFileUpload.url.url),
            let mimeType = MimeType(rawValue: documentContent.documentFileUpload.mimeType) {
            return DocumentMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: transform(message.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: transform(replyToFragment),
                content: Media(
                    type: .pdf,
                    fileName: documentContent.documentFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: URL(string: documentContent.documentFileUpload.thumbnail?.url.url),
                    mimeType: mimeType
                )
            )
        } else if
            let audioContent = message.content.fragments.messageContentFragment.asAudioMessageContent?.fragments.audioMessageContentFragment,
            let url = URL(string: audioContent.audioFileUpload.url.fragments.ephemeralUrlFragment.url),
            let mimeType = MimeType(rawValue: audioContent.audioFileUpload.mimeType) {
            return AudioMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: transform(message.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: transform(replyToFragment),
                content: AudioFile(
                    media: Media(
                        type: .audio,
                        fileName: audioContent.audioFileUpload.fileName,
                        fileUrl: url,
                        thumbnailUrl: nil,
                        mimeType: mimeType
                    ),
                    durationMs: audioContent.audioFileUpload.durationMs ?? 0
                )
            )
        }

        assertionFailure("Unknown message content \(String(describing: message.content))")
        return nil
    }

    private static func transform(_ replyTo: GQL.ReplyMessageFragment?) -> ConversationMessage? {
        guard let replyTo = replyTo else { return nil }
        let messageContentFragment = replyTo.content.fragments.messageContentFragment
        if let textContent = messageContentFragment.asTextMessageContent?.fragments.textMessageContentFragment {
            return TextMessageItem(
                id: replyTo.id,
                date: replyTo.createdAt,
                sender: transform(replyTo.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: nil,
                content: textContent.text
            )
        } else if messageContentFragment.asDeletedMessageContent != nil {
            return DeletedMessageItem(
                id: replyTo.id,
                date: replyTo.createdAt,
                sender: transform(replyTo.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: nil
            )
        } else if
            let imageContent = messageContentFragment.asImageMessageContent?.fragments.imageMessageContentFragment,
            let url = URL(string: imageContent.imageFileUpload.url.url),
            let mimeType = MimeType(rawValue: imageContent.imageFileUpload.mimeType) {
            return ImageMessageItem(
                id: replyTo.id,
                date: replyTo.createdAt,
                sender: transform(replyTo.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: nil,
                content: Media(
                    type: .image,
                    fileName: imageContent.imageFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: url,
                    mimeType: mimeType
                )
            )
        } else if
            let documentContent = messageContentFragment.asDocumentMessageContent?.fragments.documentMessageContentFragment,
            let url = URL(string: documentContent.documentFileUpload.url.url),
            let mimeType = MimeType(rawValue: documentContent.documentFileUpload.mimeType) {
            return DocumentMessageItem(
                id: replyTo.id,
                date: replyTo.createdAt,
                sender: transform(replyTo.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: nil,
                content: Media(
                    type: .pdf,
                    fileName: documentContent.documentFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: URL(string: documentContent.documentFileUpload.thumbnail?.url.url),
                    mimeType: mimeType
                )
            )
        } else if
            let audioContent = messageContentFragment.asAudioMessageContent?.fragments.audioMessageContentFragment,
            let url = URL(string: audioContent.audioFileUpload.url.fragments.ephemeralUrlFragment.url),
            let mimeType = MimeType(rawValue: audioContent.audioFileUpload.mimeType) {
            return AudioMessageItem(
                id: replyTo.id,
                date: replyTo.createdAt,
                sender: transform(replyTo.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: nil,
                content: AudioFile(
                    media: Media(
                        type: .audio,
                        fileName: audioContent.audioFileUpload.fileName,
                        fileUrl: url,
                        thumbnailUrl: nil,
                        mimeType: mimeType
                    ),
                    durationMs: audioContent.audioFileUpload.durationMs ?? 0
                )
            )
        }

        assertionFailure("Unknown message content \(String(describing: replyTo.content))")
        return nil
    }
    
    private static func transform(_ author: GQL.MessageAuthorFragment) -> ConversationMessageSender {
        if let provider = author.asProvider?.fragments.providerFragment {
            return .provider(RemoteConversationProviderTransformer.transform(provider: provider))
        } else if author.asPatient != nil {
            return .patient
        } else if let system = author.asSystem?.fragments.systemMessageFragment {
            return .system(RemoteConversationProviderTransformer.transform(system))
        } else if author.asDeletedProvider != nil {
            return .deleted
        } else {
            assertionFailure("[Should not get here] Received an unknown author type \(author.__typename)")
            return .unknown
        }
    }

    private static func transform(_ activity: GQL.ConversationActivityFragment) -> ConversationItem? {
        let provider = activity.content.provider.fragments.maybeProviderFragment
        return ConversationActivity(
            id: activity.id,
            date: activity.activityTime,
            activity: .providerJoined(RemoteConversationProviderTransformer.transform(maybeProvider: provider))
        )
    }
}
