import Foundation

typealias RemoteConversationWithItems = GQL.GetConversationItemsQuery.Data

extension RemoteConversationWithItems {
    var typingProviders: [GQL.ProviderInConversationFragment] {
        conversation
            .conversation
            .providers
            .map(\.fragments.providerInConversationFragment)
            .filter(\.isTyping)
    }
}
