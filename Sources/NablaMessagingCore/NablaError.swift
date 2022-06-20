public enum NablaError: Error {
    case authenticationError(AuthenticationError)

    public enum AuthenticationError: Error {
        case missingAuthenticationProvider
        case authenticationProviderFailedToProvideTokens
        case authenticationProviderDidProvideExpiredTokens
        case authorizationDenied(Error)
        case failedToRefreshTokens(Error)
    }
    
    case providerNotFound(String?)
    case providerMissingPermission(String?)

    case networkError(String?)
    case serverError(String?)

    case internalError(Error)

    case invalidMessage
    case messageNotFound
    case cannotReadFileData

    case unknownError(Error)
}
