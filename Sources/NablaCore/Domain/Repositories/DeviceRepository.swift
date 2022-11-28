import Foundation

protocol DeviceRepository {
    func updateOrRegisterDevice(withModules modules: [Module]) -> NablaCancellable
}

final class DeviceRepositoryImpl: DeviceRepository {
    func updateOrRegisterDevice(withModules modules: [Module]) -> NablaCancellable {
        let installation = Installation(
            deviceId: deviceLocalDataSource.deviceId,
            deviceModel: deviceLocalDataSource.deviceModel,
            deviceOSVersion: deviceLocalDataSource.deviceOSVersion,
            codeVersion: deviceLocalDataSource.codeVersion,
            modules: modules.map(serialize(_:))
        )
        return deviceRemoteDataSource.updateOrRegisterDevice(
            installation: installation,
            handler: .init { [deviceLocalDataSource, logger] result in
                switch result {
                case let .failure(error):
                    logger.error(message: "Failed to register device", extra: ["error": error])
                case let .success(remoteDevice):
                    deviceLocalDataSource.deviceId = remoteDevice.deviceId
                    if let sentry = remoteDevice.sentry {
                        self.errorReporter.enable(dsn: sentry.dsn, env: sentry.env)
                    } else {
                        self.errorReporter.disable()
                    }
                    logger.info(message: "Registered device", extra: ["id": remoteDevice.deviceId])
                }
            }
        )
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
