import Foundation

public class InternalError: NablaError {
    public let underlyingError: Error
    
    public init(underlyingError: Error) {
        self.underlyingError = underlyingError
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["underlyingError": underlyingError], uniquingKeysWith: { _, rhs in rhs })
    }
}
