import Foundation
@testable import NablaMessagingCore

extension Provider {
    static func mock() -> Provider {
        providerCount += 1
        return Provider(
            id: .init(),
            avatarURL: nil,
            prefix: "Prefix \(providerCount)",
            firstName: "FirstName \(providerCount)",
            lastName: "LastName \(providerCount)"
        )
    }
    
    private static var providerCount = 0
}
