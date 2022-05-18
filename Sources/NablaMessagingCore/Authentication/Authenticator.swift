import Foundation

enum AuthenticationState {
    case notAuthenticated
    case authenticated(accessToken: String)
}

protocol Authenticator {
    func authenticate(
        userId: UUID,
        provider: SessionTokenProvider
    )
    func logOut()
    func getAccessToken(handler: ResultHandler<AuthenticationState, NablaAuthenticationError>)
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    func isSessionInitialized() -> Bool
}
