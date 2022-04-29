import Foundation

typealias RemoteConversationWithItems = GQL.GetConversationItemsQuery.Data

extension RemoteConversationWithItems {
    var typingProviders: [GQL.ProviderInConversationFragment] {
        conversation
            .conversation
            .providers
            .map(\.fragments.providerInConversationFragment)
            .filter { provider in
                provider.typingAt.map { $0 > Date(timeIntervalSinceNow: -60) } ?? false
            }
    }
}
