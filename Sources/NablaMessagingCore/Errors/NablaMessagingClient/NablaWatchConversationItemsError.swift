public typealias NablaWatchConversationItemsError = NablaError.WatchConversationItemsError

public extension NablaError {
    enum WatchConversationItemsError: Error {
        case technicalError(TechnicalError)
    }
}
