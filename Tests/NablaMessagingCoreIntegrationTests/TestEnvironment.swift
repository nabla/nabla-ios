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
        let userId = "64cffe69-0746-46ea-979b-13f933958087"
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
                // Expires 19/03/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2NGNmZmU2OS0wNzQ2LTQ2ZWEtOTc5Yi0xM2Y5MzM5NTgwODciLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IkJlYXJlciIsImV4cCI6MjY2MDY1NDE4MSwic2Vzc2lvbl91dWlkIjoiYTQzZWI4YjgtMzMyMS00NTk3LWIyNmUtYzVjZDZmODQ2YmQ4Iiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.8TPWc93epthhHRY7aUTzaaV0O6ynACx3O_zuIceeCQM",
                // Expires 19/03/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2NGNmZmU2OS0wNzQ2LTQ2ZWEtOTc5Yi0xM2Y5MzM5NTgwODciLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IlJlZnJlc2giLCJleHAiOjI2Njg0Mjk4ODEsInNlc3Npb25fdXVpZCI6ImE0M2ViOGI4LTMzMjEtNDU5Ny1iMjZlLWM1Y2Q2Zjg0NmJkOCIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.dpaqFygTHBKthnPJEFECHUChUZ9i8A3X0XzDOh_WJm8"
            )
        )
    }
}
