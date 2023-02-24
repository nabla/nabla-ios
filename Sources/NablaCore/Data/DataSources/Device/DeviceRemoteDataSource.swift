#if canImport(ApolloAPI)
    import ApolloAPI
#else
    import Apollo
#endif
import Foundation

struct Installation {
    let deviceId: UUID?
    let deviceModel: String
    let deviceOSVersion: String
    let codeVersion: Int
    let modules: [GraphQLEnum<GQL.SdkModule>]
}

protocol DeviceRemoteDataSource {
    /// - Throws: ``GQLError``
    func updateOrRegisterDevice(installation: Installation) async throws -> RemoteDevice
}
