import Foundation

struct ConversationListItemViewModel {
    let avatar: AvatarViewModel
    let title: String
    let subtitle: String?
    let lastUpdatedTime: String
    let isUnread: Bool
}
