public typealias NablaWatchConversationError = NablaError.WatchConversationError

public extension NablaError {
    enum WatchConversationError: Error {
        case technicalError(TechnicalError)
    }
}
