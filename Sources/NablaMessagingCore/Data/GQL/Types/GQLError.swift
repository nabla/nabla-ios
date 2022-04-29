import Foundation

public enum GQLError: Error {
    case unknownError
    case emptyServerResponse
    case entityNotFound(path: [String])
    case internalServerError(message: String?)
    case incompatibleServerSchema(message: String?)
    case cacheError(CacheError)
    
    public enum CacheError: Error {
        case queryNotCached
        case entityNotCached
        case normalizationFailed(object: Any)
        case unexpectedError
    }
}
