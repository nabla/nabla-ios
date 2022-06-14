import Foundation
import NablaMessagingCore

struct AudioMessageViewItem: ConversationViewMessageItem {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let replyTo: ConversationViewMessageItem?
    let audio: AudioFile
    var isContiguous: Bool = false
    var isFocused: Bool = false
}

extension AudioMessageViewItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(sender)
        hasher.combine(sendingState)
        hasher.combine(audio)
        hasher.combine(isContiguous)
        hasher.combine(isFocused)
    }

    static func == (lhs: AudioMessageViewItem, rhs: AudioMessageViewItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
