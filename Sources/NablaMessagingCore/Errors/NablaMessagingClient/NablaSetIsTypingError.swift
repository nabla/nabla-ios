public typealias NablaSetIsTypingError = NablaError.SetIsTypingError

public extension NablaError {
    enum SetIsTypingError: Error {
        case technicalError(TechnicalError)
    }
}
