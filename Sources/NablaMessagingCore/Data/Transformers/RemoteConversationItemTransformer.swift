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
            let url = URL(string: imageContent.imageFileUpload.url.url) {
            let size: Media.Size?
            if
                let width = imageContent.imageFileUpload.width,
                let height = imageContent.imageFileUpload.height {
                size = .init(width: width, height: height)
            } else {
                size = nil
            }
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
                    mimeType: .image(.from(rawValue: imageContent.imageFileUpload.mimeType)),
                    size: size
                )
            )
        } else if
            let documentContent = message.content.fragments.messageContentFragment.asDocumentMessageContent?.fragments.documentMessageContentFragment,
            let url = URL(string: documentContent.documentFileUpload.url.url) {
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
                    mimeType: .document(.from(rawValue: documentContent.documentFileUpload.mimeType)),
                    size: nil
                )
            )
        } else if
            let audioContent = message.content.fragments.messageContentFragment.asAudioMessageContent?.fragments.audioMessageContentFragment,
            let url = URL(string: audioContent.audioFileUpload.url.fragments.ephemeralUrlFragment.url) {
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
                        mimeType: .audio(.from(rawValue: audioContent.audioFileUpload.mimeType)),
                        size: nil
                    ),
                    durationMs: audioContent.audioFileUpload.durationMs ?? 0
                )
            )
        } else if
            let videoContent = message.content.fragments.messageContentFragment.asVideoMessageContent?.fragments.videoMessageContentFragment,
            let url = URL(string: videoContent.videoFileUpload.url.url) {
            let size: Media.Size?
            if
                let width = videoContent.videoFileUpload.width,
                let height = videoContent.videoFileUpload.height {
                size = .init(width: width, height: height)
            } else {
                size = nil
            }
            return VideoMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: transform(message.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: transform(replyToFragment),
                content: Media(
                    type: .video,
                    fileName: videoContent.videoFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: nil,
                    mimeType: .video(.from(rawValue: videoContent.videoFileUpload.mimeType)),
                    size: size
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
            let url = URL(string: imageContent.imageFileUpload.url.url) {
            let size: Media.Size?
            if
                let width = imageContent.imageFileUpload.width,
                let height = imageContent.imageFileUpload.height {
                size = .init(width: width, height: height)
            } else {
                size = nil
            }
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
                    mimeType: .image(.from(rawValue: imageContent.imageFileUpload.mimeType)),
                    size: size
                )
            )
        } else if
            let documentContent = messageContentFragment.asDocumentMessageContent?.fragments.documentMessageContentFragment,
            let url = URL(string: documentContent.documentFileUpload.url.url) {
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
                    mimeType: .document(.from(rawValue: documentContent.documentFileUpload.mimeType)),
                    size: nil
                )
            )
        } else if
            let audioContent = messageContentFragment.asAudioMessageContent?.fragments.audioMessageContentFragment,
            let url = URL(string: audioContent.audioFileUpload.url.fragments.ephemeralUrlFragment.url) {
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
                        mimeType: .audio(.from(rawValue: audioContent.audioFileUpload.mimeType)),
                        size: nil
                    ),
                    durationMs: audioContent.audioFileUpload.durationMs ?? 0
                )
            )
        } else if
            let videoContent = messageContentFragment.asVideoMessageContent?.fragments.videoMessageContentFragment,
            let url = URL(string: videoContent.videoFileUpload.url.url) {
            let size: Media.Size?
            if
                let width = videoContent.videoFileUpload.width,
                let height = videoContent.videoFileUpload.height {
                size = .init(width: width, height: height)
            } else {
                size = nil
            }
            return VideoMessageItem(
                id: replyTo.id,
                date: replyTo.createdAt,
                sender: transform(replyTo.author.fragments.messageAuthorFragment),
                sendingState: .sent,
                replyTo: nil,
                content: Media(
                    type: .video,
                    fileName: videoContent.videoFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: nil,
                    mimeType: .video(.from(rawValue: videoContent.videoFileUpload.mimeType)),
                    size: size
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
