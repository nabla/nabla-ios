import Foundation

public enum AuthenticationState {
    case notAuthenticated
    case authenticated(accessToken: String)
}

// sourcery: AutoMockable
public protocol Authenticator {
    func authenticate(
        userId: String,
        provider: SessionTokenProvider
    )
    func logOut()
    /// - Throws: ``AuthenticationError``
    func getAccessToken() async throws -> AuthenticationState
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    func isSessionInitialized() -> Bool
}
