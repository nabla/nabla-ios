import Apollo
import Foundation

extension GQL.BigDecimal: Apollo.JSONDecodable, Apollo.JSONEncodable {
    public init(jsonValue: JSONValue) throws {
        if let doubleValue = jsonValue as? Double {
            self = Decimal(floatLiteral: doubleValue)
        } else if let stringValue = jsonValue as? String, let value = Decimal(string: stringValue) {
            self = value
        } else {
            throw CustomScalarParsingError(message: "Expected to parse a Decimal but \(jsonValue) is not a valid Decimal")
        }
    }
    
    public var jsonValue: JSONValue {
        description
    }
}
