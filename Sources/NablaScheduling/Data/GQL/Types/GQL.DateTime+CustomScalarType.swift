import Apollo
#if canImport(ApolloAPI)
    import ApolloAPI
#endif
import Foundation

extension GQL.DateTime: CustomScalarType {
    public init(_jsonValue value: JSONValue) throws {
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

    // swiftlint:disable:next identifier_name
    public var _jsonValue: JSONValue {
        nabla.toIsoString()
    }
}
