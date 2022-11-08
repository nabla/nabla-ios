import Foundation

/// Nabla SDK Configuration.
public struct Configuration {
    // MARK: - Public

    /// Nabla SDK Configuration parameters.
    /// - Parameters:
    ///   - apiKey: Your organisation's API key (created online on Nabla dashboard).
    ///   - logger: Instance receiving all logs emitted by the SDK. Defaults to `ConsoleLogger` based on `os_log`.
    public init(
        apiKey: String,
        logger: Logger = ConsoleLogger()
    ) {
        self.apiKey = apiKey
        self.logger = logger
    }

    // MARK: - Internal

    let apiKey: String
    let logger: Logger
}
