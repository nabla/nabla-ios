import Foundation

final class InitializeInteractorImpl: InitializeInteractor {
    // MARK: - Internal
    
    func execute(apiKey: String) {
        // Immediatly set up sentry to receive errors
        if let sentry = deviceRepository.retrieveSentryConfiguration() {
            errorReporter.enable(dsn: sentry.dsn, env: sentry.env, sdkVersion: environment.version)
        }
        extraHeaders.set(formatApiKey(apiKey), for: HTTPHeaders.NablaApiKey)
    }
    
    init(
        deviceRepository: DeviceRepository,
        errorReporter: ErrorReporter,
        environment: Environment,
        extraHeaders: ExtraHeaders
    ) {
        self.deviceRepository = deviceRepository
        self.errorReporter = errorReporter
        self.environment = environment
        self.extraHeaders = extraHeaders
    }
    
    // MARK: - Private
    
    private let deviceRepository: DeviceRepository
    private let errorReporter: ErrorReporter
    private let environment: Environment
    private let extraHeaders: ExtraHeaders
    
    private func formatApiKey(_ apiKey: String) -> String {
        apiKey.replacingOccurrences(of: "Authorization: Bearer ", with: "")
    }
}
