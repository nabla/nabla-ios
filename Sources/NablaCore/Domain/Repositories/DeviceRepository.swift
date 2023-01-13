import Foundation

protocol DeviceRepository {
    func updateOrRegisterDevice(userId: String, withModules modules: [Module]) async
}

final class DeviceRepositoryImpl: DeviceRepository {
    func updateOrRegisterDevice(userId: String, withModules modules: [Module]) async {
        let installation = Installation(
            deviceId: deviceLocalDataSource.getDeviceId(forUserId: userId),
            deviceModel: deviceLocalDataSource.deviceModel,
            deviceOSVersion: deviceLocalDataSource.deviceOSVersion,
            codeVersion: deviceLocalDataSource.codeVersion,
            modules: modules.map(serialize(_:))
        )
        do {
            let remoteDevice = try await deviceRemoteDataSource.updateOrRegisterDevice(installation: installation)
            deviceLocalDataSource.setDeviceId(remoteDevice.deviceId, forUserId: userId)
            if let sentry = remoteDevice.sentry {
                await MainActor.run {
                    errorReporter.enable(dsn: sentry.dsn, env: sentry.env, sdkVersion: environment.version)
                }
            } else {
                errorReporter.disable()
            }
            logger.info(message: "Registered device", extra: ["id": remoteDevice.deviceId])
        } catch {
            logger.error(message: "Failed to register device", error: error)
        }
    }

    // MARK: Init

    init(
        deviceLocalDataSource: DeviceLocalDataSource,
        deviceRemoteDataSource: DeviceRemoteDataSource,
        logger: Logger,
        errorReporter: ErrorReporter,
        environment: Environment
    ) {
        self.deviceLocalDataSource = deviceLocalDataSource
        self.deviceRemoteDataSource = deviceRemoteDataSource
        self.logger = logger
        self.errorReporter = errorReporter
        self.environment = environment
    }

    // MARK: - Private

    private let environment: Environment
    private let deviceLocalDataSource: DeviceLocalDataSource
    private let deviceRemoteDataSource: DeviceRemoteDataSource
    private let logger: Logger
    private let errorReporter: ErrorReporter

    private func serialize(_ module: Module) -> GQL.SdkModule {
        if module is MessagingModule {
            return .messaging
        }
        if module is VideoCallModule {
            return .videoCall
        }
        if module is SchedulingModule {
            return .videoCallScheduling
        }
        return .__unknown(String(reflecting: module))
    }
}
