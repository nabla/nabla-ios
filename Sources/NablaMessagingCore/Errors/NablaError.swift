typealias NablaTechnicalError = NablaError.TechnicalError

public enum NablaError {
    public enum TechnicalError: Error {
        case authenticationError(AuthenticationError)
        case serverError(message: String?)
        case networkError(message: String?)
        case internalError(Error)

        init(gqlError: GQLError) {
            switch gqlError {
            case let .authenticationError(error):
                self = .authenticationError(error)
            case let .networkError(message):
                self = .networkError(message: message)
            case let .serverError(message):
                self = .serverError(message: message)
            default:
                self = .internalError(gqlError)
            }
        }
    }
}
