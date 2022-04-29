import Foundation

enum RemoteConversationItemTransformer {
    static func transform(_ remoteConversationItem: RemoteConversationItem) -> ConversationItem? {
        let message = remoteConversationItem.fragments.messageFragment
        let sender: ConversationItemSender
        
        if let provider = message.author.asProvider?.fragments.providerFragment {
            sender = .provider(RemoteConversationProviderTransformer.transform(provider))
        } else if message.author.asPatient != nil {
            sender = .patient
        } else if message.author.asSystem != nil {
            sender = .system
        } else if message.author.asDeletedProvider != nil {
            sender = .deleted
        } else {
            fatalError("[Should not get here] Received an unknown author type \(message.author.__typename)")
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
        } else if
            let imageContent = message.content?.fragments.messageContentFragment.asImageMessageContent?.fragments.imageMessageContentFragment,
            let url = URL(string: imageContent.imageFileUpload.url.url),
            let mimeType = MimeType(rawValue: imageContent.imageFileUpload.mimeType) {
            return ImageMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: sender,
                state: .sent,
                content: Media(
                    type: .image,
                    fileName: imageContent.imageFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: url,
                    mimeType: mimeType
                )
            )
        } else if
            let documentContent = message.content?.fragments.messageContentFragment.asDocumentMessageContent?.fragments.documentMessageContentFragment,
            let url = URL(string: documentContent.documentFileUpload.url.url),
            let mimeType = MimeType(rawValue: documentContent.documentFileUpload.mimeType) {
            return DocumentMessageItem(
                id: message.id,
                date: message.createdAt,
                sender: sender,
                state: .sent,
                content: Media(
                    type: .pdf,
                    fileName: documentContent.documentFileUpload.fileName,
                    fileUrl: url,
                    thumbnailUrl: URL(string: documentContent.documentFileUpload.thumbnail?.url.url),
                    mimeType: mimeType
                )
            )
        }
        
        assertionFailure("Unknown remote conversation item content \(String(describing: message.content))")
        return nil
    }
}
