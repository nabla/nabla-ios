import Foundation

struct LocalConversation {
    let id: UUID
    var remoteId: UUID?
    let creationDate: Date
    let title: String?
    let providerIds: [UUID]?
}
