public typealias NablaRetrySendingMessageError = NablaError.RetrySendingMessageError

public extension NablaError {
    enum RetrySendingMessageError: Error {
        case conversationItemNotFound
        case invalidMessage
        case notSupported
        case cannotReadFileData
        case uploadError(Error)
        case technicalError(TechnicalError)
    }
}
