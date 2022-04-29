import Foundation

class EnvironmentImpl: Environment {
    var serverUrl: URL {
        var components = URLComponents()
        components.host = configuration.domain
        components.scheme = configuration.scheme
        components.port = configuration.port
        components.path = configuration.path
        // swiftlint:disable:next force_unwrapping
        return components.url!
    }
    
    var graphqlPath: String {
        "v1/patient/graphql/sdk/authenticated"
    }
    
    var graphqlHttpUrl: URL {
        serverUrl.appendingPathComponent(graphqlPath)
    }
    
    var graphqlWebSocketUrl: URL {
        var components = URLComponents()
        components.host = configuration.domain
        components.scheme = configuration.scheme == "https" ? "wss" : "ws"
        components.port = configuration.port
        components.path = configuration.path
        // swiftlint:disable:next force_unwrapping
        return components.url!.appendingPathComponent(graphqlPath)
    }
    
    var packageName: String {
        "nabla-ios-sdk"
    }
    
    var packageVersion: String {
        var version = String()
        if let shortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            version.append(shortVersion)
        }
        
        if let buildNumber = Bundle.main.object(forInfoDictionaryKey: String(kCFBundleVersionKey)) as? String {
            if version.isEmpty {
                version.append(buildNumber)
            } else {
                version.append("-\(buildNumber)")
            }
        }
        
        if version.isEmpty {
            version = "(unknown)"
        }
        
        return version
    }
    
    init(
        configuration: Configuration
    ) {
        self.configuration = configuration
    }
    
    // MARK: - Private
    
    private let configuration: Configuration
}
