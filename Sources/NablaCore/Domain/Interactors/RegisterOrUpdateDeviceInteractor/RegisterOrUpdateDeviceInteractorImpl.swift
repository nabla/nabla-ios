import Foundation

protocol RegisterDeviceInteractor {
    func execute() -> NablaCancellable
}

final class RegisterDeviceInteractorImpl: RegisterDeviceInteractor {
    // MARK: - Internal
    
    func execute() -> NablaCancellable {
        deviceRepository.updateOrRegisterDevice(withModules: modules)
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
