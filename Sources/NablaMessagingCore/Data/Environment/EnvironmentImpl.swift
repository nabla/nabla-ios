import Foundation

class EnvironmentImpl: Environment {
    let platform = "ios"
    let version = "1.0.0-alpha05"
    
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
    
    init(
        configuration: Configuration
    ) {
        self.configuration = configuration
    }
    
    // MARK: - Private
    
    private let configuration: Configuration
}
