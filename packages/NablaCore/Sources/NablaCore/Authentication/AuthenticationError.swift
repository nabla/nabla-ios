import Foundation

public enum AuthenticationError: Error {
    case missingAuthenticationProvider
    case authenticationProviderFailedToProvideTokens
    case authorizationDenied(Error)
    case failedToRefreshTokens(Error)
}
