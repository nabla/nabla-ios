import Foundation

struct Provider: Hashable {
    let id: UUID
    let prefix: String?
    let firstName: String
    let lastName: String
    let title: String?
    let avatarUrl: URL?
}
