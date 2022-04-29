import Foundation
import NablaMessagingCore

struct HasMoreIndicatorViewItem: ConversationViewItem, Hashable {
    let id: UUID = Self.id
    let date: Date = .distantPast
    
    // Make sure `id` is unique and stable to prevent cell updates
    private static let id = UUID()
}
