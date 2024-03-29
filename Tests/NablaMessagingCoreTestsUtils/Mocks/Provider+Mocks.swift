import Foundation
@testable import NablaMessagingCore

public extension Provider {
    static func mock(
        prefix: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        avatarUrl: String? = nil
    ) -> Provider {
        providerCount += 1
        return Provider(
            id: .init(),
            avatarURL: avatarUrl,
            prefix: prefix ?? "Prefix \(providerCount)",
            firstName: firstName ?? "FirstName \(providerCount)",
            lastName: lastName ?? "LastName \(providerCount)"
        )
    }
    
    private static var providerCount = 0
}
