import Foundation

struct Installation {
    let deviceId: UUID?
    let deviceModel: String
    let deviceOSVersion: String
    let codeVersion: Int
    let modules: [GQL.SdkModule]
}

protocol DeviceRemoteDataSource {
    /// - Throws: ``GQLError``
    func updateOrRegisterDevice(installation: Installation) async throws -> RemoteDevice
}
