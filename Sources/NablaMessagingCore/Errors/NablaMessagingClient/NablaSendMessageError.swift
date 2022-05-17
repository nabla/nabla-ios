public typealias NablaSendMessageError = NablaError.SendMessageError

public extension NablaError {
    enum SendMessageError: Error {
        case invalidMessage
        case notSupported
        case cannotReadFileData
        case uploadError(Error)
        case technicalError(TechnicalError)
    }
}
