import Foundation

public struct User: Hashable, Codable {
    public let label: String
    public let uuid: UUID
}
