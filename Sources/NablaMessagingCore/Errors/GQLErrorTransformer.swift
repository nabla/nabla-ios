enum GQLErrorTransformer {
    static func transform(gqlError: GQLError) -> NablaError {
        switch gqlError {
        case .internalError:
            return .internalError(gqlError)
        case .emptyServerResponse:
            return .serverError("Empty server response")
        case .unknownError:
            return .serverError(gqlError.localizedDescription)
        case let .incompatibleServerSchema(message),
             let .serverError(message),
             let .entityNotFound(message),
             let .permissionRequired(message):
            return .serverError(message)
        case .cacheError:
            return .internalError(gqlError)
        case let .authenticationError(authenticationError):
            return .authenticationError(authenticationError)
        case let .networkError(message):
            return .serverError(message)
        }
    }
}
