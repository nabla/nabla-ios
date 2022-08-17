import Foundation

struct CustomScalarParsingError: Error, CustomStringConvertible {
    var description: String
    
    init(message: String) {
        description = message
    }
}
