import Foundation

public enum GQLError: Error {
    case emptyServerResponse
    case cacheError(CacheError)
    
    public enum CacheError: Error {
        case queryNotCached
        case entityNotCached
        case normalizationFailed(object: Any)
        case unexpectedError
    }
}
