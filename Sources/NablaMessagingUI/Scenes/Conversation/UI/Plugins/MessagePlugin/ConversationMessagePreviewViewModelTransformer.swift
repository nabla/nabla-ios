import Foundation
import NablaCore
import NablaMessagingCore

struct ConversationMessagePreviewViewModelTransformer {
    // MARK: - Public

    static func transform(item: ConversationViewMessageItem?) -> ConversationMessagePreviewViewModel? {
        guard
            let item = item else {
            return nil
        }

        let author: String
        switch item.sender {
        case let .patient(patient):
            author = patient.displayName
        case .me:
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
            return .init(
                icon: nil,
                author: author,
                text: textMessage.text,
                image: nil
            )
        } else if let imageMessage = item as? ImageMessageViewItem {
            return .init(
                icon: NablaTheme.Conversation.replyToImageIcon,
                author: author,
                text: L10n.conversationReplyToPreviewPicture,
                image: imageMessage.image.source
            )
        } else if item is VideoMessageViewItem {
            return .init(
                icon: NablaTheme.Conversation.replyToVideoIcon,
                author: author,
                text: L10n.conversationReplyToPreviewVideo,
                image: nil
            )
        } else if let documentMessage = item as? DocumentMessageViewItem {
            return .init(
                icon: NablaTheme.Conversation.replyToDocumentIcon,
                author: author,
                text: L10n.conversationReplyToPreviewDocument,
                image: documentMessage.document.thumbnail
            )
        } else if item as? AudioMessageViewItem != nil {
            return .init(
                icon: NablaTheme.Conversation.replyToAudioIcon,
                author: author,
                text: L10n.conversationReplyToPreviewAudio,
                image: nil
            )
        } else if item as? DeletedMessageViewItem != nil {
            return .init(
                icon: nil,
                author: author,
                text: L10n.conversationDeletedMessage,
                image: nil
            )
        }

        return nil
    }
}
