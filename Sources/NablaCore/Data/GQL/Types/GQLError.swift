import Foundation

public enum GQLError: Error {
    case unknownError
    case emptyServerResponse
    case entityNotFound(message: String?)
    case permissionRequired(message: String?)
    case incompatibleServerSchema(message: String?)
    case cacheError(CacheError)

    case serverError(message: String?)
    case authenticationError(AuthenticationError)
    case networkError(message: String?)
    
    public enum CacheError: Error {
        case queryNotCached
        case entityNotCached
        case normalizationFailed(object: Any)
        case unexpectedError
    }
}
