typealias NablaAuthenticationError = NablaError.AuthenticationError

public extension NablaError {
    enum AuthenticationError: Error {
        case missingAuthenticationProvider
        case authenticationProviderFailedToProvideTokens
        case authorizationDenied(Error)
        case failedToRefreshTokens(Error)
    }
}
