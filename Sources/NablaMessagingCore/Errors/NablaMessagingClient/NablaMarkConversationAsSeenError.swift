public typealias NablaMarkConversationAsSeenError = NablaError.MarkConversationAsSeenError

public extension NablaError {
    enum MarkConversationAsSeenError: Error {
        case technicalError(TechnicalError)
    }
}
