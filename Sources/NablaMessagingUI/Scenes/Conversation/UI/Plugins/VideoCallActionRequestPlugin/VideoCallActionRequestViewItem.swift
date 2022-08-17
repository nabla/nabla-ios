import Foundation
import NablaMessagingCore

struct VideoCallActionRequestViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    var room: Room?
    var isContiguous: Bool = false
    var isFocused: Bool = false
    
    var replyTo: ConversationViewMessageItem? { nil }
    
    struct Room: Hashable {
        let url: String
        let token: String
    }
}
