import Foundation
import NablaMessagingCore

class FakeAuthenticator: SessionTokenProvider {
    static let shared = FakeAuthenticator()
    
    func provideTokens(completion: (Tokens?) -> Void) {
        completion(.init(
            accessToken: "<youraccesstoken>",
            refreshToken: "<yourrefreshtoken>"
        ))
    }
}
