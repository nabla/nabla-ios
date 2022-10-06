import Foundation
import NablaCore
import NablaMessagingCore

extension ProviderNameComponents {
    init(_ provider: Provider) {
        self.init()
        prefix = provider.prefix
        firstName = provider.firstName
        lastName = provider.lastName
    }

    init(_ maybeProvider: MaybeProvider) {
        self.init()
        switch maybeProvider {
        case .deletedProvider:
            prefix = L10n.providerDeletedName
        case let .provider(provider):
            prefix = provider.prefix
            firstName = provider.firstName
            lastName = provider.lastName
        }
    }
}
