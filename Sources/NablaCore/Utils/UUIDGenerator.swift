import Foundation

public protocol UUIDGenerator {
    func generate() -> UUID
}

struct FoundationUUIDGenerator: UUIDGenerator {
    func generate() -> UUID {
        UUID()
    }
}
