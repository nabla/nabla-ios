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
    
    static func make(filePath: String = #filePath, function: String = #function) -> TestEnvironment {
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
            modules: []
        )
        coreContainer.urlSessionClient = MockURLSessionClient(session: session)
        coreContainer.deviceLocalDataSource = deviceLocalDataSource
        coreContainer.uuidGenerator = mockUUIDGenerator
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
                // Expires 14/08/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyM2E3Y2M5Zi1iYWJjLTRiMGUtYTI0Ny01M2YwZmMxYmM3NWMiLCJpc3MiOiJkZXY6cGF0aWVudDpuYWJsYSIsInR5cCI6IkJlYXJlciIsImV4cCI6MjY3MDMyMDAwMywic2Vzc2lvbl91dWlkIjoiMjllNmU5MjUtZWNlMy00Mjg2LWFiOTAtOTE1OTkyMWY1OGIyIiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.g3hCledHFjNce6n6lAV9fksIWIM92oXHUyu-6DkNQIE",
                // Expires 12/11/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyM2E3Y2M5Zi1iYWJjLTRiMGUtYTI0Ny01M2YwZmMxYmM3NWMiLCJpc3MiOiJkZXY6cGF0aWVudDpuYWJsYSIsInR5cCI6IlJlZnJlc2giLCJleHAiOjI2NzgwOTU3MDMsInNlc3Npb25fdXVpZCI6IjI5ZTZlOTI1LWVjZTMtNDI4Ni1hYjkwLTkxNTk5MjFmNThiMiIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.jW3WaRblAX9roCULLxai8-cwGS6OBENgvoZzu_lGn7Y"
            )
        )
    }
}
