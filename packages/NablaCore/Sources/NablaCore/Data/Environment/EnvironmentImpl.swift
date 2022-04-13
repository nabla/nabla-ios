import Foundation

class EnvironmentImpl: Environment {
    var serverUrl: URL {
        var components = URLComponents()
        components.host = configuration.domain
        components.scheme = configuration.scheme
        // swiftlint:disable:next force_unwrapping
        return components.url!
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
