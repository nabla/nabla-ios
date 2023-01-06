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
                errorReporter.enable(dsn: sentry.dsn, env: sentry.env)
            } else {
                errorReporter.disable()
            }
            logger.info(message: "Registered device", extra: ["id": remoteDevice.deviceId])
        } catch {
            logger.error(message: "Failed to register device", extra: ["error": error])
        }
    }

    // MARK: Init

    init(
        deviceLocalDataSource: DeviceLocalDataSource,
        deviceRemoteDataSource: DeviceRemoteDataSource,
        logger: Logger,
        errorReporter: ErrorReporter
    ) {
        self.deviceLocalDataSource = deviceLocalDataSource
        self.deviceRemoteDataSource = deviceRemoteDataSource
        self.logger = logger
        self.errorReporter = errorReporter
    }

    // MARK: - Private

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
