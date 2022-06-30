import Foundation

public class InternalError: NablaError {
    public let underlyingError: Error
    
    init(underlyingError: Error) {
        self.underlyingError = underlyingError
    }
}
