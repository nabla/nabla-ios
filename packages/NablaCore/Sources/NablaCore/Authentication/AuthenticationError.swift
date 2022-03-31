import Foundation

public enum AuthenticationError: Error {
    case missingAuthenticationProvider
    case authenticationProviderFailedToProvideTokens
}
