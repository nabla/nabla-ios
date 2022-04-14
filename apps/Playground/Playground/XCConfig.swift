import Foundation
import NablaCore

enum Env: String {
    case production
    case staging
    case development
}

class XCConfig: Configuration {
    @Property(key: "PLAYGROUND_ENV")
    private var rawEnv: String
    
    var env: Env {
        Env(rawValue: rawEnv) ?? .development
    }
    
    @Property(key: "PLAYGROUND_API_DOMAIN")
    var domain: String
    
    @Property(key: "PLAYGROUND_API_SCHEME")
    var scheme: String
    
    @Property(key: "PLAYGROUND_IAP_CLIENT_ID")
    var iapClientId: String
    
    @Property(key: "PLAYGROUND_IAP_SERVER_ID")
    var iapServerId: String
    
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
