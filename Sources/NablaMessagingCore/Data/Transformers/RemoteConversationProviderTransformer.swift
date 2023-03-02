import Foundation

enum RemoteConversationProviderTransformer {
    static func transform(provider: GQL.ProviderFragment) -> Provider {
        .init(
            id: provider.id,
            avatarURL: provider.avatarUrl?.fragments.ephemeralUrlFragment.url,
            prefix: provider.prefix,
            firstName: provider.firstName,
            lastName: provider.lastName
        )
    }

    static func transform(maybeProvider: GQL.MaybeProviderFragment) -> MaybeProvider? {
        if maybeProvider.asDeletedProvider != nil {
            return .deletedProvider
        } else if let providerFragment = maybeProvider.asProvider?.fragments.providerFragment {
            let provider = Self.transform(provider: providerFragment)
            return .provider(provider)
        }
        return nil
    }

    static func transform(_ system: GQL.SystemMessageFragment) -> SystemProvider {
        .init(
            avatarURL: system.avatar?.url.fragments.ephemeralUrlFragment.url,
            name: system.name
        )
    }
}
