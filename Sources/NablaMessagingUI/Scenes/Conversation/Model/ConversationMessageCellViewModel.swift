import Foundation
import NablaCore
import UIKit

struct ConversationMessageThemViewModel {
    let author: String
    let avatar: AvatarViewModel
    let isContiguous: Bool
}

struct ConversationMessageFooterViewModel {
    let text: String
    let color: UIColor
}

enum ConversationMessageSender {
    case me(isContiguous: Bool)
    case them(ConversationMessageThemViewModel)
}

struct ConversationMessageViewModel<ContentViewModel> {
    let sender: ConversationMessageSender
    let footer: ConversationMessageFooterViewModel?
    let replyTo: ConversationMessagePreviewViewModel?
    let content: ContentViewModel
    let menuElements: [UIMenuElement]
}
