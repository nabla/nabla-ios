import Foundation

struct DateSeparatorViewItem: ConversationViewItem, Hashable {
    let id: UUID
    let date: Date
    let text: String
}
