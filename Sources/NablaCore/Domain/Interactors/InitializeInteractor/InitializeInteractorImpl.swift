import Combine
import Foundation

final class InitializeInteractorImpl: InitializeInteractor {
    // MARK: - Internal
    
    func execute(apiKey: String) {
        extraHeaders.set(formatApiKey(apiKey), for: HTTPHeaders.NablaApiKey)
        
        sentryConfigurationObserver = deviceRepository
            .watchSentryConfiguration()
            .sink(receiveValue: { [errorReporter, environment] configuration in
                errorReporter.enable(dsn: configuration.dsn, env: configuration.env, sdkVersion: environment.version)
            })
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
    
    private var sentryConfigurationObserver: AnyCancellable?
    
    private func formatApiKey(_ apiKey: String) -> String {
        apiKey.replacingOccurrences(of: "Authorization: Bearer ", with: "")
    }
}
