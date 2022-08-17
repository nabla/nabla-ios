import Foundation

public protocol NetworkConfiguration {
    var serverUrl: String { get }
}

struct DefaultNetworkConfiguration: NetworkConfiguration {
    let serverUrl = "https://livekit.nabla.com"
}
