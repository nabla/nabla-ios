import Foundation
import NablaCore
import NablaMessagingCore

enum AvatarViewModelTransformer {
    static func avatar(for conversation: Conversation) -> AvatarViewModel {
        if let pictureUrl = conversation.pictureUrl {
            return AvatarViewModel(url: pictureUrl.absoluteString, text: nil)
        }

        let provider = conversation.providers.first?.provider
        return AvatarViewModel(
            url: provider?.avatarURL,
            text: provider.flatMap {
                ProviderNameComponentsFormatter(style: .initials).string(from: .init($0)).nabla.nilIfEmpty
            }
        )
    }
}
