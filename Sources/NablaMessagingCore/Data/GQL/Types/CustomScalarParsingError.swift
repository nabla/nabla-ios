import Foundation

public struct CustomScalarParsingError: Error, CustomStringConvertible {
    public var description: String
    
    public init(message: String) {
        description = message
    }
}
