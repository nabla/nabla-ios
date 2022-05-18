public enum NablaError: Error {
    case authenticationError(AuthenticationError)

    public enum AuthenticationError: Error {
        case missingAuthenticationProvider
        case authenticationProviderFailedToProvideTokens
        case authorizationDenied(Error)
        case failedToRefreshTokens(Error)
    }

    case networkError(String?)
    case serverError(String?)

    case internalError(Error)

    case invalidMessage
    case messageNotFound
    case cannotReadFileData

    case unknownError(Error)
}
