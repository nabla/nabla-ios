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
            networkConfiguration: networkConfiguration,
            logger: ConsoleLogger(),
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
                // Expires 04/08/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlODRkYjBlMi02YTdjLTRmZjMtYjFjYi03MmFmYjZhNGJjNzgiLCJpc3MiOiJwcm9kLXBhdGllbnQiLCJ0eXAiOiJCZWFyZXIiLCJleHAiOjI2NjY3OTk0NDQsInNlc3Npb25fdXVpZCI6ImQyNDU0YWRkLTUzYmEtNGQ4OC1hNGI2LWU2MmNiYzQ1ZjMyNSIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.c95itI_iJNMHWputGyeH_LX5pjD7XUjkpOU7dgjHkwo",
                // Expires 04/08/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlODRkYjBlMi02YTdjLTRmZjMtYjFjYi03MmFmYjZhNGJjNzgiLCJpc3MiOiJwcm9kLXBhdGllbnQiLCJ0eXAiOiJSZWZyZXNoIiwiZXhwIjoyNjc0NTc1MTQ0LCJzZXNzaW9uX3V1aWQiOiJkMjQ1NGFkZC01M2JhLTRkODgtYTRiNi1lNjJjYmM0NWYzMjUiLCJvcmdhbml6YXRpb25TdHJpbmdJZCI6Im5hYmxhIn0.eGNP0iCR9n6gcltl-SLZdzb3fBq-hVPmNVt3V-CX7lY"
            )
        )
    }
}
