import Foundation

public enum AuthenticationState {
    case notAuthenticated
    case authenticated(accessToken: String)
}

public protocol Authenticator {
    func authenticate(
        userId: String,
        provider: SessionTokenProvider
    )
    func logOut()
    func getAccessToken(handler: ResultHandler<AuthenticationState, AuthenticationError>)
    /// - Throws: ``AuthenticationError``
    func getAccessToken() async throws -> AuthenticationState
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    func isSessionInitialized() -> Bool
}
