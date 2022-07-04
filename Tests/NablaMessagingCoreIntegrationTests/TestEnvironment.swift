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
        let userId = UUID(uuidString: "f004ddd7-2013-490a-a021-c422014cddc6")!
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
                // Expires 07/06/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmMDA0ZGRkNy0yMDEzLTQ5MGEtYTAyMS1jNDIyMDE0Y2RkYzYiLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IkJlYXJlciIsImV4cCI6MjY1NjY4NDkyOSwic2Vzc2lvbl91dWlkIjoiOTNmOGRkNjUtNzE2Ny00NjY0LWFkMWItZWYwZjM5Mjc2YzU2Iiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.Bc4-99CMnWESw88X2a0U9psxe22Zb5hoEX0taK_XYlQ",
                // Expires 07/06/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmMDA0ZGRkNy0yMDEzLTQ5MGEtYTAyMS1jNDIyMDE0Y2RkYzYiLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IlJlZnJlc2giLCJleHAiOjI2NjQ0NjA2MjksInNlc3Npb25fdXVpZCI6IjkzZjhkZDY1LTcxNjctNDY2NC1hZDFiLWVmMGYzOTI3NmM1NiIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.tI9kvGuS8AyTbr307OSWtdAuWvC94whRDI2oC0536bs"
            )
        )
    }
}
