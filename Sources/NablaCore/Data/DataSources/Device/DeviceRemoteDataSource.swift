import Foundation

struct Installation {
    let deviceId: UUID?
    let deviceModel: String
    let deviceOSVersion: String
    let codeVersion: Int
    let modules: [GQL.SdkModule]
}

protocol DeviceRemoteDataSource {
    func updateOrRegisterDevice(installation: Installation, handler: ResultHandler<RemoteDevice, GQLError>) -> Cancellable
}
