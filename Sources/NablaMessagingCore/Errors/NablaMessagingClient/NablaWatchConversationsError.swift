public typealias NablaWatchConversationsError = NablaError.WatchConversationsError

public extension NablaError {
    enum WatchConversationsError: Error {
        case technicalError(TechnicalError)
    }
}
