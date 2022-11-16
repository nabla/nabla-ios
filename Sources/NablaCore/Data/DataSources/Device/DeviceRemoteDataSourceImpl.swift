import Foundation

final class DeviceRemoteDataSourceImpl: DeviceRemoteDataSource {
    // MARK: - Internal
    
    func updateOrRegisterDevice(installation: Installation, handler: ResultHandler<RemoteDevice, GQLError>) -> Cancellable {
        let input = makeDeviceInput(installation: installation)
        return gqlClient.perform(
            mutation: GQL.RegisterOrUpdateDeviceMutation(deviceId: installation.deviceId, input: input),
            handler: handler.pullback { $0.registerOrUpdateDevice }
        )
    }
    
    // MARK: Init
    
    init(
        gqlClient: GQLClient
    ) {
        self.gqlClient = gqlClient
    }
    
    // MARK: - Private

    private let gqlClient: GQLClient
    
    private func makeDeviceInput(installation: Installation) -> GQL.DeviceInput {
        GQL.DeviceInput(
            deviceModel: installation.deviceModel,
            os: .ios,
            osVersion: installation.deviceOSVersion,
            codeVersion: installation.codeVersion,
            sdkModules: installation.modules
        )
    }
}
