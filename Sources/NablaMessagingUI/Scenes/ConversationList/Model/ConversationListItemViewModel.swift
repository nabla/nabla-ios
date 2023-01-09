import Foundation
import NablaCore

struct ConversationListItemViewModel: Hashable {
    let id: UUID
    let avatar: AvatarViewModel
    let title: String
    let subtitle: String?
    let lastUpdatedTime: String
    let isUnread: Bool

    func hasChanged(otherItem: ConversationListItemViewModel) -> Bool {
        avatar != otherItem.avatar
            || title != otherItem.title
            || subtitle != otherItem.subtitle
            || lastUpdatedTime != otherItem.lastUpdatedTime
            || isUnread != otherItem.isUnread
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ConversationListItemViewModel, rhs: ConversationListItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
