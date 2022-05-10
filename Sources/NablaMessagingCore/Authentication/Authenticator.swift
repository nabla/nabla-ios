import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated(accessToken: String)
}

protocol Authenticator {
    func authenticate(
        userId: UUID,
        provider: SessionTokenProvider
    )
    func logOut()
    func getAccessToken(completion: @escaping (Result<AuthenticationState, AuthenticationError>) -> Void)
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
}
