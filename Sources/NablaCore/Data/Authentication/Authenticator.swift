import Foundation

public enum AuthenticationState {
    case notAuthenticated
    case authenticated(accessToken: String)
}

// sourcery: AutoMockable
public protocol Authenticator {
    var currentUserId: String? { get }
    
    func authenticate(userId: String)
    func logOut()
    func markTokensAsInvalid()
    /// - Throws: ``AuthenticationError``
    func getAccessToken() async throws -> AuthenticationState
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    func isSessionInitialized() -> Bool
}
