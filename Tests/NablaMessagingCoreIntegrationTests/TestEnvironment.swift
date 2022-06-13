import DVR
import Foundation
@testable import NablaMessagingCore

struct TestEnvironment {
    struct Configuration: NablaMessagingCore.Configuration {
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
        let userId = UUID(uuidString: "96C3DBC7-744F-44A0-9D7B-8A4C493C7370")!
        let session = makeMockSession(filePath: filePath, function: function)
        let configuration = Configuration(session: session)
        let container = CoreContainer(
            name: "tests",
            configuration: configuration,
            logger: ConsoleLogger()
        )
        container.urlSessionClient = MockURLSessionClient(session: session)
        let nablaClient = NablaClient(
            apiKey: "test-api-key",
            container: container
        )
        let messagingClient = NablaMessagingClient(client: nablaClient)
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
                // Expires 30/01/2054
                accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5NmMzZGJjNy03NDRmLTQ0YTAtOWQ3Yi04YTRjNDkzYzczNzAiLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IkJlYXJlciIsImV4cCI6MjY1MzQwODQxNiwic2Vzc2lvbl91dWlkIjoiMDY3ZjczOTUtMTMxZC00NGViLWJjZTgtZTY1MjAyYmY5MTZhIiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.1IeGSx5M-DhuHL47r7U3KLNvjLCPDKDq-EHEMV-1720",
                // Expires 30/01/2054
                refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5NmMzZGJjNy03NDRmLTQ0YTAtOWQ3Yi04YTRjNDkzYzczNzAiLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IlJlZnJlc2giLCJleHAiOjI2NjExODQxMTYsInNlc3Npb25fdXVpZCI6IjA2N2Y3Mzk1LTEzMWQtNDRlYi1iY2U4LWU2NTIwMmJmOTE2YSIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.hzhmxTPoukAv26oZIV2acQRwkbJLf6w5XYAjGNHdb6c"
            )
        )
    }
}
