import Foundation

enum RemoteConversationProviderTransformer {
    static func transform(_ provider: GQL.ProviderFragment) -> Provider {
        .init(
            id: provider.id,
            avatarURL: provider.avatarUrl?.fragments.ephemeralUrlFragment.url,
            prefix: provider.prefix,
            firstName: provider.firstName,
            lastName: provider.lastName
        )
    }
}
