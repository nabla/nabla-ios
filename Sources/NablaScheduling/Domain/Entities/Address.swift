import Foundation

public struct Address: Equatable {
    public let id: UUID
    public let address: String
    public let zipCode: String
    public let city: String
    public let state: String?
    public let country: String?
    public let extraDetails: String?
}
