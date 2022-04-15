import Foundation
import NablaCore

enum Env: String {
    case production
    case staging
    case development
}

class XCConfig: Configuration {
    // MARK: - Internal
    
    static var current = XCConfig()
    
    var env: Env {
        Env(rawValue: rawEnv) ?? .development
    }
    
    @StringValue(key: "PLAYGROUND_API_DOMAIN")
    var domain: String
    
    @StringValue(key: "PLAYGROUND_API_SCHEME")
    var scheme: String
    
    @IntValue(key: "PLAYGROUND_API_PORT")
    var port: Int?
    
    @StringValue(key: "PLAYGROUND_API_PATH")
    var path: String
    
    @StringValue(key: "PLAYGROUND_API_TOKEN")
    var apiToken: String
    
    @BoolValue(key: "PLAYGROUND_IAP_REQUIRED", default: false)
    var iapRequired: Bool
    
    @StringValue(key: "PLAYGROUND_IAP_CLIENT_ID")
    var iapClientId: String
    
    @StringValue(key: "PLAYGROUND_IAP_SERVER_ID")
    var iapServerId: String
    
    // MARK: - Private
    
    @StringValue(key: "PLAYGROUND_ENV")
    private var rawEnv: String
    
    @propertyWrapper
    struct StringValue {
        let key: String

        var wrappedValue: String {
            guard let rawValue = Bundle.main.object(forInfoDictionaryKey: key) else {
                fatalError("Missing \(key) key in bundle.")
            }
            guard let value = rawValue as? String else {
                fatalError("Cannot convert \(rawValue) to `String`.")
            }
            return value
        }
    }
    
    @propertyWrapper
    struct IntValue {
        let key: String

        var wrappedValue: Int? {
            guard let rawValue = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
                fatalError("Missing \(key) key in bundle.")
            }
            if rawValue.isEmpty {
                return nil
            }
            guard let value = Int(rawValue) else {
                fatalError("Cannot convert \(rawValue) to `Int`.")
            }
            return value
        }
    }
    
    @propertyWrapper
    struct BoolValue {
        let key: String
        let `default`: Bool

        var wrappedValue: Bool {
            guard let rawValue = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
                fatalError("Missing \(key) key in bundle.")
            }
            if rawValue.isEmpty {
                return `default`
            }
            guard let value = Bool(rawValue) else {
                fatalError("Cannot convert \(rawValue) to `Bool`.")
            }
            return value
        }
    }
}
