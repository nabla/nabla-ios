import Foundation

protocol RegisterDeviceInteractor {
    func execute(userId: String) async
}

final class RegisterDeviceInteractorImpl: RegisterDeviceInteractor {
    // MARK: - Internal
    
    func execute(userId: String) async {
        await deviceRepository.updateOrRegisterDevice(userId: userId, withModules: modules)
    }
    
    // MARK: Init
    
    init(
        modules: [Module],
        deviceRepository: DeviceRepository
    ) {
        self.modules = modules
        self.deviceRepository = deviceRepository
    }
    
    // MARK: - Private
    
    private let modules: [Module]
    private let deviceRepository: DeviceRepository
}
