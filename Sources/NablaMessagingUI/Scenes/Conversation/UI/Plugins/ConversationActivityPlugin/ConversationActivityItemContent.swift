import Foundation
import NablaMessagingCore

struct ConversationActivityViewItem: ConversationViewItem, Hashable {
    let id: UUID
    let date: Date
    let activity: ConversationActivity.Activity
}
