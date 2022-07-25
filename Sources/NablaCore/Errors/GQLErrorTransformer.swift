import Foundation

public enum GQLErrorTransformer {
    public static func transform(gqlError: GQLError) -> NablaError {
        switch gqlError {
        case .internalError:
            return InternalError(underlyingError: gqlError)
        case .emptyServerResponse:
            return ServerError(message: "Empty server response")
        case .unknownError:
            return ServerError(underlyingError: gqlError)
        case let .incompatibleServerSchema(message),
             let .serverError(message),
             let .entityNotFound(message),
             let .permissionRequired(message):
            return ServerError(message: message)
        case .cacheError:
            return InternalError(underlyingError: gqlError)
        case let .authenticationError(authenticationError):
            return authenticationError
        case let .networkError(message):
            return NetworkError(message: message)
        }
    }
}
