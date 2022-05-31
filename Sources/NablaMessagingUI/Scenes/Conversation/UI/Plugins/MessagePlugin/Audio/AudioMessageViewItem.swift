import Foundation
import NablaMessagingCore

struct AudioMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let audio: AudioFile
    var isContiguous: Bool = false
}
