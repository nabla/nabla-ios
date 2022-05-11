import Foundation

typealias RemoteConversationItem = GQL.ConversationItemFragment

extension RemoteConversationItem {
    var id: UUID? {
        if let message = asMessage {
            return message.fragments.messageFragment.id
        }
        if let conversationActivity = asConversationActivity {
            return conversationActivity.fragments.conversationActivityFragment.id
        }
        // Every single `RemoteConversationItem` should have an `id`
        assertionFailure("Unknown `RemoteConversationItem` type: \(__typename)")
        return nil
    }
    
    var clientId: UUID? {
        if let message = asMessage {
            return message.fragments.messageFragment.clientId
        }
        // Not every `RemoteConversationItem` have a `clientId`
        return nil
    }
}
