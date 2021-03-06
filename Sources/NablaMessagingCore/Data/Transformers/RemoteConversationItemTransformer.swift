import Foundation
import NablaCore

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
            let size: MediaSize?
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
                content: ImageFile(
                    fileName: imageContent.imageFileUpload.fileName,
                    fileUrl: url,
                    size: size,
                    mimeType: .from(rawValue: imageContent.imageFileUpload.mimeType)
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
                content: DocumentFile(
                    fileName: documentContent.documentFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: URL(string: documentContent.documentFileUpload.thumbnail?.url.url),
                    mimeType: .from(rawValue: documentContent.documentFileUpload.mimeType)
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
                    fileName: audioContent.audioFileUpload.fileName,
                    fileUrl: url,
                    durationMs: audioContent.audioFileUpload.durationMs ?? 0,
                    mimeType: .from(rawValue: audioContent.audioFileUpload.mimeType)
                )
            )
        } else if
            let videoContent = message.content.fragments.messageContentFragment.asVideoMessageContent?.fragments.videoMessageContentFragment,
            let url = URL(string: videoContent.videoFileUpload.url.url) {
            let size: MediaSize?
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
                content: VideoFile(
                    fileName: videoContent.videoFileUpload.fileName,
                    fileUrl: url,
                    size: size,
                    mimeType: .from(rawValue: videoContent.videoFileUpload.mimeType)
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
            let size: MediaSize?
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
                content: ImageFile(
                    fileName: imageContent.imageFileUpload.fileName,
                    fileUrl: url,
                    size: size,
                    mimeType: .from(rawValue: imageContent.imageFileUpload.mimeType)
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
                content: DocumentFile(
                    fileName: documentContent.documentFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: URL(string: documentContent.documentFileUpload.thumbnail?.url.url),
                    mimeType: .from(rawValue: documentContent.documentFileUpload.mimeType)
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
                    fileName: audioContent.audioFileUpload.fileName,
                    fileUrl: url,
                    durationMs: audioContent.audioFileUpload.durationMs ?? 0,
                    mimeType: .from(rawValue: audioContent.audioFileUpload.mimeType)
                )
            )
        } else if
            let videoContent = messageContentFragment.asVideoMessageContent?.fragments.videoMessageContentFragment,
            let url = URL(string: videoContent.videoFileUpload.url.url) {
            let size: MediaSize?
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
                content: VideoFile(
                    fileName: videoContent.videoFileUpload.fileName,
                    fileUrl: url,
                    size: size,
                    mimeType: .from(rawValue: videoContent.videoFileUpload.mimeType)
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
