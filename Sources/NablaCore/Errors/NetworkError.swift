import Foundation

public class NetworkError: NablaError {
    public let message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["message": message ?? "nil"], uniquingKeysWith: { _, rhs in rhs })
    }
}
