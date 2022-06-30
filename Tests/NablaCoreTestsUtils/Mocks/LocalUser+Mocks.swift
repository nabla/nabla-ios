@testable import NablaCore

/// This extension can not be `public` because `LocalUser` ain't.
/// Use `@testable NablaCoreTestsUtils` instead.
extension LocalUser {
    static func mock() -> LocalUser {
        LocalUser(id: .init())
    }
}
