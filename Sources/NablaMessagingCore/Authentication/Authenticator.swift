import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated(accessToken: String)
}

protocol Authenticator {
    func authenticate(
        provider: NablaAuthenticationProvider,
        completion: (Result<Void, AuthenticationError>) -> Void
    )
    func logOut()
    func getAccessToken(completion: @escaping (Result<AuthenticationState, AuthenticationError>) -> Void)
}
