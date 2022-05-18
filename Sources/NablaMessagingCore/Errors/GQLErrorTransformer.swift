enum GQLErrorTransformer {
    static func transform(gqlError: GQLError) -> NablaError {
        switch gqlError {
        case .internalError:
            return .internalError(gqlError)
        case .emptyServerResponse:
            return .serverError("Empty server response")
        case .entityNotFound:
            return .serverError("Entity not found")
        case .unknownError:
            return .serverError(gqlError.localizedDescription)
        case let .incompatibleServerSchema(message),
             let .serverError(message):
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
