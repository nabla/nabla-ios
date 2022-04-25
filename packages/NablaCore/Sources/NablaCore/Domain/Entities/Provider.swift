import Foundation

public struct Provider: Hashable {
    public let id: UUID
    public let avatarURL: String?

    public init(id: UUID, avatarURL: String?) {
        self.id = id
        self.avatarURL = avatarURL
    }
}
