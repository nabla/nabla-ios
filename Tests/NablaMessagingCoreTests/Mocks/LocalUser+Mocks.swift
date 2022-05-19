@testable import NablaMessagingCore

extension LocalUser {
    static func mock() -> LocalUser {
        LocalUser(id: .init())
    }
}
