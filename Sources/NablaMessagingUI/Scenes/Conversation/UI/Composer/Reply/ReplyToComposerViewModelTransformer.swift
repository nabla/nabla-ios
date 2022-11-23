import Foundation
import NablaCore
import NablaMessagingCore
import UIKit

struct ReplyToComposerViewModelTransformer {
    // MARK: - Public

    static func transform(message: ConversationViewMessageItem) -> ReplyToComposerViewModel {
        ReplyToComposerViewModel(
            sender: message.replySender,
            preview: message.preview,
            imagePreview: message.imagePreview
        )
    }
}

private extension ConversationViewMessageItem {
    var replySender: String {
        let name: String
        switch sender {
        case let .provider(provider):
            name = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider))
        case let .system(system):
            name = system.name
        case let .patient(patient):
            name = patient.displayName
        case .me:
            name = L10n.conversationReplyToAuthorYou
        case .deleted:
            name = L10n.conversationReplyToAuthorDeletedProvider
        case .unknown:
            return L10n.conversationReplyToAuthorUnknownAuthor
        }
        return L10n.conversationReplyToAuthor(name)
    }

    var preview: String {
        if let textMessage = self as? TextMessageViewItem {
            return textMessage.text
        } else if self as? ImageMessageViewItem != nil {
            return L10n.conversationReplyToPreviewPicture
        } else if self as? DocumentMessageViewItem != nil {
            return L10n.conversationReplyToPreviewDocument
        } else if self as? AudioMessageViewItem != nil {
            return L10n.conversationReplyToPreviewAudio
        } else if self as? VideoMessageViewItem != nil {
            return L10n.conversationReplyToPreviewVideo
        }
        return L10n.conversationReplyToPreviewUnknown
    }

    var imagePreview: ImageSource? {
        if let imageMessage = self as? ImageMessageViewItem {
            return imageMessage.image.source
        }
        return nil
    }
}
