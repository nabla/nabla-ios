public typealias NablaDeleteMessageError = NablaError.DeleteMessageError

public extension NablaError {
    enum DeleteMessageError: Error {
        case technicalError(TechnicalError)
    }
}
