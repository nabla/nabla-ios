import Apollo
#if canImport(ApolloAPI)
    import ApolloAPI
#endif
import Foundation

extension GQL.UUID: CustomScalarType {
    public init(_jsonValue value: JSONValue) throws {
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

    // swiftlint:disable:next identifier_name
    public var _jsonValue: JSONValue {
        uuidString
    }
}
