import Foundation

struct EventViewItem: ConversationViewItem, Hashable {
    let id: UUID
    let date: Date
    let text: String
}
