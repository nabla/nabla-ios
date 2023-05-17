import Combine
import Foundation

public enum AuthenticationState {
    case notAuthenticated
    case authenticated(accessToken: String)
}

// sourcery: AutoMockable
public protocol Authenticator {
    func logOut()
    func markTokensAsInvalid()
    
    /// - Throws: ``AuthenticationError``
    func getAuthenticationState() async throws -> AuthenticationState
    func watchAuthenticationState() -> AnyPublisher<AuthenticationState, Never>
}
