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
    
    static func make(filePath: String = #filePath, function: String = #function) async throws -> TestEnvironment {
        let userId = "e84db0e2-6a7c-4ff3-b1cb-72afb6a4bc78"
        let session = makeMockSession(filePath: filePath, function: function)
        let mockUUIDGenerator = MockUUIDGenerator()

        let deviceLocalDataSource = DeviceLocalDataSourceMock()
        deviceLocalDataSource.given(.getDeviceId(forUserId: .any, willProduce: { stubber in stubber.return(nil) }))
        deviceLocalDataSource.given(.codeVersion(getter: 42))
        deviceLocalDataSource.given(.deviceModel(getter: "Mocked: Simulator"))
        deviceLocalDataSource.given(.deviceOSVersion(getter: "Mocked: iOS13"))
        var configuration = Configuration(
            apiKey: "test-api-key",
            logger: ConsoleLogger()
        )
        configuration.network = NetworkConfiguration(session: session)
        let coreContainer = CoreContainer(
            name: "tests",
            configuration: configuration,
            urlSessionClient: MockURLSessionClient(session: session),
            deviceLocalDataSource: deviceLocalDataSource,
            uuidGenerator: mockUUIDGenerator,
            modules: [],
            sessionTokenProvider: MockSessionTokenProvider()
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
        
        await nablaClient.clearCurrentUser()
        try nablaClient.setCurrentUser(userId: userId)
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

private final class MockSessionTokenProvider: SessionTokenProvider {
    func provideTokens(forUserId _: String, completion: (AuthTokens?) -> Void) {
        completion(
            .init(
                // Expires 17/09/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyM2E3Y2M5Zi1iYWJjLTRiMGUtYTI0Ny01M2YwZmMxYmM3NWMiLCJzZXNzaW9uX2xvZ2luX21ldGhvZCI6Im9uZV90aW1lX3Rva2VuIiwiaXNzIjoiZGV2OnBhdGllbnQ6bmFibGEiLCJ0eXAiOiJCZWFyZXIiLCJleHAiOjI2NzcxNjA0MzAsInNlc3Npb25fdXVpZCI6IjI2OGM2MjFjLTMyMWYtNDQ2NS1hOWI2LWI5NGFhMTY2MjI5ZSIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.ppMNzZYsmFuBpM3FytHwptYjkOYL5XCB5BomFdi_NLE",
                // Expires 17/09/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyM2E3Y2M5Zi1iYWJjLTRiMGUtYTI0Ny01M2YwZmMxYmM3NWMiLCJzZXNzaW9uX2xvZ2luX21ldGhvZCI6Im9uZV90aW1lX3Rva2VuIiwiaXNzIjoiZGV2OnBhdGllbnQ6bmFibGEiLCJ0eXAiOiJSZWZyZXNoIiwiZXhwIjoyNjg0OTM2MTMwLCJzZXNzaW9uX3V1aWQiOiIyNjhjNjIxYy0zMjFmLTQ0NjUtYTliNi1iOTRhYTE2NjIyOWUiLCJvcmdhbml6YXRpb25TdHJpbmdJZCI6Im5hYmxhIn0.VyDjIeReJF7pF4_QvfnMHupX5x81OXWrZj9aYOolzRY"
            )
        )
    }
}
