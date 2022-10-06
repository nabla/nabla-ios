import Foundation
import NablaCore

struct ConversationMessageSenderTransformer {
    // MARK: - Public

    static func transform(item: ConversationViewMessageItem) -> ConversationMessageSender {
        switch item.sender { case let .provider(provider):
            return .them(.init(
                author: ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider)),
                avatar: .init(
                    url: provider.avatarURL,
                    text: ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider)).nabla.nilIfEmpty
                ),
                isContiguous: item.isContiguous
            ))
        case let .system(system):
            return .them(.init(
                author: system.name,
                avatar: .init(url: system.avatarURL, text: system.initials),
                isContiguous: item.isContiguous
            ))
        case .deleted:
            return .them(.init(
                author: L10n.conversationMessageDeletedSender,
                avatar: .init(url: nil, text: nil),
                isContiguous: item.isContiguous
            ))
        case .unknown:
            return .them(.init(
                author: L10n.conversationMessageUnknownSender,
                avatar: .init(url: nil, text: nil),
                isContiguous: item.isContiguous
            ))
        case .patient:
            return .me(isContiguous: item.isContiguous)
        }
    }
}
