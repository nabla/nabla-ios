import DVR
import Foundation
@testable import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore

struct TestEnvironment {
    struct NetworkConfiguration: NablaCore.NetworkConfiguration {
        let domain = "localhost"
        let scheme = "http"
        let port: Int? = 8080
        let path = ""
        let session: URLSession
    }
    
    let nablaClient: NablaClient
    let messagingClient: NablaMessagingClient
    let session: DVR.Session
    let mockUUIDGenerator: MockUUIDGenerator
    
    static func make(filePath: String = #filePath, function: String = #function) async -> TestEnvironment {
        let userId = "e84db0e2-6a7c-4ff3-b1cb-72afb6a4bc78"
        let session = makeMockSession(filePath: filePath, function: function)
        let networkConfiguration = NetworkConfiguration(session: session)
        let mockUUIDGenerator = MockUUIDGenerator()

        let deviceLocalDataSource = DeviceLocalDataSourceMock()
        deviceLocalDataSource.given(.getDeviceId(forUserId: .any, willProduce: { stubber in stubber.return(nil) }))
        deviceLocalDataSource.given(.codeVersion(getter: 42))
        deviceLocalDataSource.given(.deviceModel(getter: "Mocked: Simulator"))
        deviceLocalDataSource.given(.deviceOSVersion(getter: "Mocked: iOS13"))
        
        let coreContainer = CoreContainer(
            name: "tests",
            configuration: .init(
                apiKey: "test-api-key",
                logger: ConsoleLogger()
            ),
            networkConfiguration: networkConfiguration,
            urlSessionClient: MockURLSessionClient(session: session),
            deviceLocalDataSource: deviceLocalDataSource,
            uuidGenerator: mockUUIDGenerator,
            modules: []
        )
        let nablaClient = NablaClient(
            apiKey: "test-api-key",
            container: coreContainer
        )
        let messagingContainer = MessagingContainer(coreContainer: coreContainer)
        let messagingClient = NablaMessagingClient(container: messagingContainer)
        let env = TestEnvironment(
            nablaClient: nablaClient,
            messagingClient: messagingClient,
            session: session,
            mockUUIDGenerator: mockUUIDGenerator
        )
        
        // TODO: use `NablaClient.logOut()` instead
        await coreContainer.logOutInteractor.execute()
        
        nablaClient.authenticate(userId: userId, provider: env)
        return env
    }
    
    private static func makeMockSession(filePath: String, function: String) -> DVR.Session {
        // swiftlint:disable:next force_unwrapping
        var outputDirectory = URL(string: filePath)!
        outputDirectory.deletePathExtension()
        let cassetteName = function
            .replacingOccurrences(of: "\\(.*\\)", with: "", options: .regularExpression)
            .appending(".cassette")
        return Session(
            outputDirectory: outputDirectory.absoluteString,
            cassetteName: cassetteName,
            testBundle: NablaMessagingCoreIntegrationTestsPackage.bunble
        )
    }
}

extension TestEnvironment: SessionTokenProvider {
    func provideTokens(forUserId _: String, completion: (AuthTokens?) -> Void) {
        completion(
            .init(
                // Expires 17/09/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlODRkYjBlMi02YTdjLTRmZjMtYjFjYi03MmFmYjZhNGJjNzgiLCJpc3MiOiJwcm9kLXBhdGllbnQiLCJ0eXAiOiJCZWFyZXIiLCJleHAiOjEyNjcwNTc2MjExLCJzZXNzaW9uX3V1aWQiOiJjZGUwOTY0NS01YzM0LTQyYmQtYmQxYS0zMWYwYzExMDYzMTMiLCJvcmdhbml6YXRpb25TdHJpbmdJZCI6Im5hYmxhIn0.9oR2z4ZLJTYMS-v7ZihACwa30eKdDRn4giGYoxgqrK0",
                // Expires 17/09/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlODRkYjBlMi02YTdjLTRmZjMtYjFjYi03MmFmYjZhNGJjNzgiLCJpc3MiOiJwcm9kLXBhdGllbnQiLCJ0eXAiOiJSZWZyZXNoIiwiZXhwIjoyNjc4MzUxOTExLCJzZXNzaW9uX3V1aWQiOiJjZGUwOTY0NS01YzM0LTQyYmQtYmQxYS0zMWYwYzExMDYzMTMiLCJvcmdhbml6YXRpb25TdHJpbmdJZCI6Im5hYmxhIn0.6OqBNXTC-2dj30WKDq7oyVHkTPAFm_NkJeZE1Zh3Bls"
            )
        )
    }
}
