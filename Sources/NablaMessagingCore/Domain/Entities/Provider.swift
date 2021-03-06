import Foundation

public struct Provider: Hashable {
    public let id: UUID
    public let avatarURL: String?
    public let prefix: String?
    public let firstName: String
    public let lastName: String
}

public enum MaybeProvider: Hashable {
    case deletedProvider
    case provider(Provider)
}
