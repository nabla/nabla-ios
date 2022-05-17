public typealias NablaCreateConversationError = NablaError.CreateConversationError

public extension NablaError {
    enum CreateConversationError: Error {
        case technicalError(TechnicalError)
    }
}
