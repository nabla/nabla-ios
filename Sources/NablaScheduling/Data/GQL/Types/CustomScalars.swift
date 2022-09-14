import Apollo
import Foundation

// List of custom scalar used for NablaScheduling resolution
extension GQL {
    typealias UUID = Foundation.UUID
    typealias ID = GraphQLID
    typealias DateTime = Date
    typealias TimeZone = String
}
