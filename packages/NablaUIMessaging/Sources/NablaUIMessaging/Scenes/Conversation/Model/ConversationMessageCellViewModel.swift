import Foundation
import UIKit

struct ConversationMessageThemViewModel {
    let author: String
    let avatar: AvatarViewModel
    let displaySenderNameAndAvatar: Bool
}

struct ConversationMessageFooterViewModel {
    let text: String
    let color: UIColor
}

enum ConversationMessageSender {
    case me
    case them(ConversationMessageThemViewModel)
}

struct ConversationMessageViewModel<ContentViewModel> {
    let sender: ConversationMessageSender
    let footer: ConversationMessageFooterViewModel?
    let content: ContentViewModel
}
