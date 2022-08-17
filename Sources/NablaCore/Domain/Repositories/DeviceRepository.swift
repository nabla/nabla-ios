import Foundation

protocol DeviceRepository {
    func updateOrRegisterDevice(withModules modules: [Module]) -> Cancellable
}

final class DeviceRepositoryImpl: DeviceRepository {
    func updateOrRegisterDevice(withModules modules: [Module]) -> Cancellable {
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
                case let .success(deviceId):
                    deviceLocalDataSource.deviceId = deviceId
                    logger.info(message: "Registered device", extra: ["id": deviceId])
                }
            }
        )
    }
    
    // MARK: Init
    
    init(
        deviceLocalDataSource: DeviceLocalDataSource,
        deviceRemoteDataSource: DeviceRemoteDataSource,
        logger: Logger
    ) {
        self.deviceLocalDataSource = deviceLocalDataSource
        self.deviceRemoteDataSource = deviceRemoteDataSource
        self.logger = logger
    }
    
    // MARK: - Private
    
    private let deviceLocalDataSource: DeviceLocalDataSource
    private let deviceRemoteDataSource: DeviceRemoteDataSource
    private let logger: Logger
    
    private func serialize(_ module: Module) -> GQL.SdkModule {
        if module is MessagingModule {
            return .messaging
        }
        if module is VideoCallModule {
            return .videoCall
        }
        return .__unknown(String(reflecting: module))
    }
}
