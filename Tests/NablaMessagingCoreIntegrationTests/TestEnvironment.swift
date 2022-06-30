import DVR
import Foundation
@testable import NablaCore
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
        // swiftlint:disable:next force_unwrapping
        let userId = UUID(uuidString: "64cffe69-0746-46ea-979b-13f933958087")!
        let session = makeMockSession(filePath: filePath, function: function)
        let networkConfiguration = NetworkConfiguration(session: session)
        let coreContainer = CoreContainer(
            name: "tests",
            networkConfiguration: networkConfiguration,
            logger: ConsoleLogger()
        )
        coreContainer.urlSessionClient = MockURLSessionClient(session: session)
        let nablaClient = NablaClient(
            apiKey: "test-api-key",
            container: coreContainer
        )
        let messagingContainer = MessagingContainer(coreContainer: coreContainer)
        let messagingClient = NablaMessagingClient(parent: nablaClient, container: messagingContainer)
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
            testBundle: Bundle.module
        )
    }
}

extension TestEnvironment: SessionTokenProvider {
    func provideTokens(forUserId _: UUID, completion: (Tokens?) -> Void) {
        completion(
            .init(
                // Expires 05/06/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2NGNmZmU2OS0wNzQ2LTQ2ZWEtOTc5Yi0xM2Y5MzM5NTgwODciLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IkJlYXJlciIsImV4cCI6MjY1NjQ5NTc2OCwic2Vzc2lvbl91dWlkIjoiZDYwNzNiNzQtYjAwNS00MjVhLTkxYTEtZGNlMzgxNjZlMGM4Iiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.TnLh-ruzwV8g7vc2Y5pgYnCXRHJvcqkpSGf7PrHZ56E",
                // Expires 05/06/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2NGNmZmU2OS0wNzQ2LTQ2ZWEtOTc5Yi0xM2Y5MzM5NTgwODciLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IlJlZnJlc2giLCJleHAiOjI2NjQyNzE0NjgsInNlc3Npb25fdXVpZCI6ImQ2MDczYjc0LWIwMDUtNDI1YS05MWExLWRjZTM4MTY2ZTBjOCIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.SyltPUcTMBLXQRxEMun6BQkpeAOGyaFqO5hIqTd2RNc"
            )
        )
    }
}
