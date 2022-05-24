import Foundation

public struct SystemProvider: Hashable {
    public let avatarURL: String?
    public let name: String
}

public extension SystemProvider {
    var initials: String? {
        name.first.map(String.init)
    }
}
