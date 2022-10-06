import Foundation
import NablaCore

struct ConversationMessagePreviewViewModelTransformer {
    // MARK: - Public

    static func transform(item: ConversationViewMessageItem?) -> ConversationMessagePreviewViewModel? {
        guard
            let item = item else {
            return nil
        }

        let author: String
        switch item.sender {
        case .patient:
            author = L10n.conversationReplyToAuthorYou
        case let .provider(provider):
            author = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider))
        case let .system(system):
            author = system.name
        case .deleted:
            author = L10n.conversationMessageDeletedSender
        case .unknown:
            author = L10n.conversationMessageUnknownSender
        }

        if let textMessage = item as? TextMessageViewItem {
            return .init(icon: nil, author: author, preview: textMessage.text, previewImageURL: nil)
        } else if let imageMessage = item as? ImageMessageViewItem {
            return .init(
                icon: NablaTheme.Conversation.replyToImageIcon,
                author: author,
                preview: L10n.conversationReplyToPreviewPicture,
                previewImageURL: imageMessage.image.fileUrl
            )
        } else if item is VideoMessageViewItem {
            return .init(
                icon: NablaTheme.Conversation.replyToVideoIcon,
                author: author,
                preview: L10n.conversationReplyToPreviewVideo,
                previewImageURL: nil
            )
        } else if let documentMessage = item as? DocumentMessageViewItem {
            return .init(
                icon: NablaTheme.Conversation.replyToDocumentIcon,
                author: author,
                preview: L10n.conversationReplyToPreviewDocument,
                previewImageURL: documentMessage.document.thumbnailUrl
            )
        } else if item as? AudioMessageViewItem != nil {
            return .init(
                icon: NablaTheme.Conversation.replyToAudioIcon,
                author: author,
                preview: L10n.conversationReplyToPreviewAudio,
                previewImageURL: nil
            )
        } else if item as? DeletedMessageViewItem != nil {
            return .init(
                icon: nil,
                author: author,
                preview: L10n.conversationDeletedMessage,
                previewImageURL: nil
            )
        }

        return nil
    }
}
