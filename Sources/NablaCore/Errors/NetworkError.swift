import Foundation

public class NetworkError: NablaError {
    public let message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}
