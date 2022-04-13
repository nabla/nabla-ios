import Foundation
import NablaCore

class XCConfig: Configuration {
    @Property(key: "PLAYGROUND_API_DOMAIN")
    var domain: String
    
    @Property(key: "PLAYGROUND_API_SCHEME")
    var scheme: String
    
    @propertyWrapper
    struct Property<T> {
        let key: String

        var wrappedValue: T {
            guard let rawValue = Bundle.main.object(forInfoDictionaryKey: key) else {
                fatalError("Missing \(key) key in bundle.")
            }
            guard let value = rawValue as? T else {
                fatalError("Unexpected bundle value for key \(key). Expected \(T.self), found \(type(of: rawValue)).")
            }
            return value
        }
    }
}
