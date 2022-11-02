import Foundation
import NablaCore
import UIKit

struct ConversationMessageProviderViewModel {
    let author: String
    let avatar: AvatarViewModel
    let isContiguous: Bool
}

struct ConversationMessageOtherViewModel {
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
    case provider(ConversationMessageProviderViewModel)
    case other(ConversationMessageOtherViewModel)
}

struct ConversationMessageViewModel<ContentViewModel> {
    let sender: ConversationMessageSender
    let footer: ConversationMessageFooterViewModel?
    let replyTo: ConversationMessagePreviewViewModel?
    let content: ContentViewModel
    let menuElements: [UIMenuElement]
}
