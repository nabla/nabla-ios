import Apollo
import Foundation

extension GQL.DateTime: Apollo.JSONDecodable, Apollo.JSONEncodable {
    public init(jsonValue: JSONValue) throws {
        let value = jsonValue
        if let stringValue = value as? String {
            if let date = Date.nabla.from(isoString: stringValue) {
                self = date
            } else {
                throw CustomScalarParsingError(message: "\(stringValue) is not a valid ISO 8601 date string.")
            }
        } else {
            throw CustomScalarParsingError(message: "Expected to parse a DateTime from a string, but received a \(type(of: value)) instead.")
        }
    }
    
    public var jsonValue: JSONValue {
        nabla.toIsoString()
    }
}
