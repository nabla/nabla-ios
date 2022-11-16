import Foundation

/// Nabla SDK Configuration.
public struct Configuration {
    // MARK: - Public

    /// Nabla SDK Configuration parameters.
    /// - Parameters:
    ///   - apiKey: Your organisation's API key (created online on Nabla dashboard).
    ///   - logger: Instance receiving all logs emitted by the SDK. Defaults to `ConsoleLogger` based on `os_log`.
    ///   - enableReporting: Boolean to enable or disable sending anonymized events to Nabla servers to help improve features like video calls. Defaults to `true`.
    public init(
        apiKey: String,
        logger: Logger = ConsoleLogger(),
        enableReporting: Bool = true
    ) {
        self.apiKey = apiKey
        self.logger = logger
        self.enableReporting = enableReporting
    }

    // MARK: - Internal

    let apiKey: String
    let logger: Logger
    let enableReporting: Bool
}
