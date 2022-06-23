import Foundation

struct ConversationMessageSenderTransformer {
    // MARK: - Public

    static func transform(item: ConversationViewMessageItem) -> ConversationMessageSender {
        switch item.sender {
        case let .provider(provider):
            return .them(.init(
                author: provider.abbreviatedNameWithPrefix,
                avatar: .init(url: provider.avatarURL, text: provider.initials),
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
