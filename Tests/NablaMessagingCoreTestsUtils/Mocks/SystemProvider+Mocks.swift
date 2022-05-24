import Foundation
@testable import NablaMessagingCore

public extension SystemProvider {
    static func mock() -> SystemProvider {
        providerCount += 1
        return SystemProvider(
            avatarURL: nil,
            name: "name \(providerCount)"
        )
    }
    
    private static var providerCount = 0
}
