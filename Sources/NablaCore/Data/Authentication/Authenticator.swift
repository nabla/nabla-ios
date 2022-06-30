import Foundation

public enum AuthenticationState {
    case notAuthenticated
    case authenticated(accessToken: String)
}

public protocol Authenticator {
    func authenticate(
        userId: UUID,
        provider: SessionTokenProvider
    )
    func logOut()
    func getAccessToken(handler: ResultHandler<AuthenticationState, AuthenticationError>)
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    func isSessionInitialized() -> Bool
}
