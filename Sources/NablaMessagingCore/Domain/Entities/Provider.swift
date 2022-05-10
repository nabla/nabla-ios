import Foundation

public struct Provider: Hashable {
    public let id: UUID
    public let avatarURL: String?
    public let prefix: String?
    public let firstName: String
    public let lastName: String
}

public extension Provider {
    var initials: String? {
        String([firstName, lastName].compactMap(\.first)).nilIfEmpty
    }
}
