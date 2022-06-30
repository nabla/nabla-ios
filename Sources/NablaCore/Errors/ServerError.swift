import Foundation

public class ServerError: NablaError {
    public let underlyingError: Error?
    public let message: String?
    
    public init(underlyingError: Error? = nil, message: String? = nil) {
        self.underlyingError = underlyingError
        self.message = message
    }
}
