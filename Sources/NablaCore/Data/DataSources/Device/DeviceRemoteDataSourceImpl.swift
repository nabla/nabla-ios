import Foundation

final class DeviceRemoteDataSourceImpl: DeviceRemoteDataSource {
    // MARK: - Internal
    
    /// - Throws: ``GQLError``
    func updateOrRegisterDevice(installation: Installation) async throws -> RemoteDevice {
        let input = makeDeviceInput(installation: installation)
        let deviceId = installation.deviceId.nabla.asGQLNullable()
        let response = try await gqlClient.perform(
            mutation: GQL.RegisterOrUpdateDeviceMutation(deviceId: deviceId, input: input)
        )
        return response.registerOrUpdateDevice
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
            os: .case(.ios),
            osVersion: .some(installation.deviceOSVersion),
            codeVersion: installation.codeVersion,
            sdkModules: installation.modules
        )
    }
}
