import Foundation

class EnvironmentImpl: Environment {
    let platform = "ios"
    let version = "1.0.0-alpha12"
    
    var serverUrl: URL {
        var components = URLComponents()
        components.host = networkConfiguration.domain
        components.scheme = networkConfiguration.scheme
        components.port = networkConfiguration.port
        components.path = networkConfiguration.path
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
        components.host = networkConfiguration.domain
        components.scheme = networkConfiguration.scheme == "https" ? "wss" : "ws"
        components.port = networkConfiguration.port
        components.path = networkConfiguration.path
        // swiftlint:disable:next force_unwrapping
        return components.url!.appendingPathComponent(graphqlPath)
    }
    
    var languageCode: String {
        Locale.current.languageCode ?? "en"
    }
    
    init(
        networkConfiguration: NetworkConfiguration
    ) {
        self.networkConfiguration = networkConfiguration
    }
    
    // MARK: - Private
    
    private let networkConfiguration: NetworkConfiguration
}
