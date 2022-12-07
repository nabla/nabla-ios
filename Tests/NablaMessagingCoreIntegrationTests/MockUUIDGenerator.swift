import Foundation
import NablaCore

final class MockUUIDGenerator: UUIDGenerator {
    var values: [UUID] = []
    private var recorded: [UUID] = []

    func generate() -> UUID {
        if values.isEmpty {
            let uuid = UUID()
            recorded.append(uuid)
            print(
                """
                env.mockUUIDGenerator.values = [
                    \(recorded.map { "UUID(uuidString: \"\($0)\")!" }.joined(separator: ",\n"))
                ]
                """
            )
            return uuid
        }
        return values.removeFirst()
    }
}
