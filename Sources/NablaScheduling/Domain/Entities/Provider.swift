import Foundation

public struct Provider: Hashable {
    public let id: UUID
    public let prefix: String?
    public let firstName: String
    public let lastName: String
    public let title: String?
    public let avatarUrl: URL?
}
