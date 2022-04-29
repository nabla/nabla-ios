import Foundation
import NablaMessagingCore

struct TypingIndicatorViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID = .init()
    let date: Date = .init()
    let sender: ConversationItemSender
    let state: ConversationItemState = .sent
    var isContiguous: Bool = false
}
