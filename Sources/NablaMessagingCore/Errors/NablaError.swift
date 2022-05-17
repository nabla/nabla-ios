typealias NablaTechnicalError = NablaError.TechnicalError

public enum NablaError {
    public enum TechnicalError: Error {
        case authenticationError(AuthenticationError)
        case serverError(Error)
        case unknown

        init(gqlError: GQLError) {
            switch gqlError {
            case let .authenticationError(error):
                self = .authenticationError(error)
            default:
                self = .serverError(gqlError)
            }
        }
    }
}
