import Foundation

struct LocalConversation {
    let id: UUID
    var remoteId: UUID?
    var creationDate: Date
    var title: String?
    var providerIds: [UUID]?
}
