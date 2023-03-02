import Foundation

public class ServerError: NablaError {
    public let underlyingError: Error?
    public let message: String?
    
    public init(underlyingError: Error? = nil, message: String? = nil) {
        self.underlyingError = underlyingError
        self.message = message
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(
            [
                "underlyingError": underlyingError ?? "nil",
                "message": message ?? "nil",
            ],
            uniquingKeysWith: { _, rhs in rhs }
        )
    }
}
