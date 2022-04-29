import Apollo
import Foundation

extension GQL.UUID: Apollo.JSONDecodable, Apollo.JSONEncodable {
    public init(jsonValue: JSONValue) throws {
        let value = jsonValue
        if let stringValue = value as? String {
            if let newVal = GQL.UUID(uuidString: stringValue) {
                self = newVal
            } else {
                throw CustomScalarParsingError(message: "\(stringValue) is not a valid UUID String")
            }
        } else {
            throw CustomScalarParsingError(message: "Expected to parse a UUID from a String, but received a \(type(of: value)) instead")
        }
    }
    
    public var jsonValue: JSONValue {
        uuidString
    }
}
