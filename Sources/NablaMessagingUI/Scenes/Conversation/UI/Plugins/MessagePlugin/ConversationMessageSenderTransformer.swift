import Foundation
import NablaCore

struct ConversationMessageSenderTransformer {
    // MARK: - Public

    static func transform(item: ConversationViewMessageItem) -> ConversationMessageSender {
        switch item.sender {
        case let .provider(provider):
            return .provider(.init(
                author: ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider)),
                avatar: .init(
                    url: provider.avatarURL,
                    text: ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider)).nabla.nilIfEmpty
                ),
                isContiguous: item.isContiguous
            ))
        case let .system(system):
            return .other(.init(
                author: system.name,
                avatar: .init(url: system.avatarURL, text: system.initials),
                isContiguous: item.isContiguous
            ))
        case .deleted:
            return .other(.init(
                author: L10n.conversationMessageDeletedSender,
                avatar: .init(url: nil, text: nil),
                isContiguous: item.isContiguous
            ))
        case .unknown:
            return .other(.init(
                author: L10n.conversationMessageUnknownSender,
                avatar: .init(url: nil, text: nil),
                isContiguous: item.isContiguous
            ))
        case let .patient(patient):
            return .other(.init(
                author: PatientNameComponentsFormatter(style: .fullName).string(from: .init(patient)),
                avatar: .init(
                    url: nil,
                    text: PatientNameComponentsFormatter(style: .initials).string(from: .init(patient)).nabla.nilIfEmpty
                ),
                isContiguous: item.isContiguous
            ))
        case .me:
            return .me(isContiguous: item.isContiguous)
        }
    }
}
