import Apollo
#if canImport(ApolloAPI)
    import ApolloAPI
#endif
import Foundation

extension GQL.BigDecimal: CustomScalarType {
    public init(_jsonValue jsonValue: JSONValue) throws {
        if let doubleValue = jsonValue as? Double {
            self = Decimal(floatLiteral: doubleValue)
        } else if let stringValue = jsonValue as? String, let value = Decimal(string: stringValue) {
            self = value
        } else {
            throw CustomScalarParsingError(message: "Expected to parse a Decimal but \(jsonValue) is not a valid Decimal")
        }
    }

    // swiftlint:disable:next identifier_name
    public var _jsonValue: JSONValue {
        description
    }
}
