import Foundation
import NablaMessagingCore

struct TypingIndicatorViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID = .init()
    let date: Date = .init()
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState = .sent
    var isContiguous: Bool = false
}
