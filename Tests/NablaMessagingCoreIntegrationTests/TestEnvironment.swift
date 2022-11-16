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
    
    static func make(filePath: String = #filePath, function: String = #function) -> TestEnvironment {
        let userId = "e84db0e2-6a7c-4ff3-b1cb-72afb6a4bc78"
        let session = makeMockSession(filePath: filePath, function: function)
        let networkConfiguration = NetworkConfiguration(session: session)
        
        let deviceLocalDataSource = DeviceLocalDataSourceMock()
        deviceLocalDataSource.given(.deviceId(getter: nil))
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
        let nablaClient = NablaClient(
            apiKey: "test-api-key",
            container: coreContainer
        )
        let messagingContainer = MessagingContainer(coreContainer: coreContainer)
        let messagingClient = NablaMessagingClient(container: messagingContainer)
        let env = TestEnvironment(
            nablaClient: nablaClient,
            messagingClient: messagingClient,
            session: session
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
                // Expires 23/10/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyM2E3Y2M5Zi1iYWJjLTRiMGUtYTI0Ny01M2YwZmMxYmM3NWMiLCJpc3MiOiJkZXY6cGF0aWVudDpuYWJsYSIsInR5cCI6IkJlYXJlciIsImV4cCI6MjY2ODYwMTM0MSwic2Vzc2lvbl91dWlkIjoiMzk5MDJlNWMtYmE4Yi00NDAxLTgxMmMtZjdhNDJjYjllMTlkIiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.ULPxh07iBDIIFZUXXpMP2Ljnr-oDIo-TsqPM4Oyjvc4",
                // Expires 23/10/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyM2E3Y2M5Zi1iYWJjLTRiMGUtYTI0Ny01M2YwZmMxYmM3NWMiLCJpc3MiOiJkZXY6cGF0aWVudDpuYWJsYSIsInR5cCI6IlJlZnJlc2giLCJleHAiOjI2NzYzNzcwNDEsInNlc3Npb25fdXVpZCI6IjM5OTAyZTVjLWJhOGItNDQwMS04MTJjLWY3YTQyY2I5ZTE5ZCIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.OREU35FKcLq0pFRoTu8khuvGJJU2JXGMKpWGoqgoveE"
            )
        )
    }
}
