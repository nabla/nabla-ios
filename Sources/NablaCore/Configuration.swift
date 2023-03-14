import Foundation

/// Nabla SDK Configuration.
public struct Configuration {
    // MARK: - Public
    
    public let apiKey: String
    public let logger: Logger
    public let enableReporting: Bool
    
    /// For testing purposes only.
    public var network: NetworkConfiguration = DefaultNetworkConfiguration()

    /// Nabla SDK Configuration parameters.
    /// - Parameters:
    ///   - apiKey: Your organisation's API key (created online on Nabla dashboard).
    ///   - enableReporting: Boolean to enable or disable sending anonymized events to Nabla servers to help improve features like video calls. Defaults to `true`.
    ///   - logger: Instance receiving all logs emitted by the SDK. Defaults to `ConsoleLogger` based on `os_log`.
    public init(
        apiKey: String,
        enableReporting: Bool = true,
        logger: Logger = ConsoleLogger()
    ) {
        self.apiKey = apiKey
        self.logger = logger
        self.enableReporting = enableReporting
    }
}
