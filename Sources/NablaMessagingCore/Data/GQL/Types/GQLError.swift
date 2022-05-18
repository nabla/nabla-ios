import Foundation

enum GQLError: Error {
    case unknownError
    case internalError
    case emptyServerResponse
    case entityNotFound(path: [String])
    case incompatibleServerSchema(message: String?)
    case cacheError(CacheError)

    case serverError(message: String?)
    case authenticationError(NablaAuthenticationError)
    case networkError(message: String?)
    
    enum CacheError: Error {
        case queryNotCached
        case entityNotCached
        case normalizationFailed(object: Any)
        case unexpectedError
    }
}
