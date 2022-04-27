import Foundation

enum RemoteConversationProviderTransformer {
    static func transform(_ provider: GQL.ProviderInConversationFragment) -> Provider {
        .init(
            id: provider.provider.fragments.providerFragment.id,
            avatarURL: provider.provider.fragments.providerFragment.avatarUrl?.fragments.ephemeralUrlFragment.url
        )
    }
}
