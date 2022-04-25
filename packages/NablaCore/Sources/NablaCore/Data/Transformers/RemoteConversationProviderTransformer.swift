import Foundation
import NablaCore

enum RemoteConversationProviderTransformer {
    static func transform(_ provider: GQL.ProviderInConversationFragment) -> Provider {
        .init(
            id: provider.id,
            avatarURL: provider.provider.fragments.providerFragment.avatarUrl?.fragments.ephemeralUrlFragment.url
        )
    }
}
