import Foundation
import NablaMessagingCore

class FakeAuthenticator: SessionTokenProvider {
    static let shared = FakeAuthenticator()
    
    func provideTokens(forUserId _: UUID, completion: (Tokens?) -> Void) {
        // Emulate a call to authenticate the user on your server
        // In your app, you need to replace this with an actual call to your backend to get fresh tokens
        completion(.init(
            accessToken: "<youraccesstoken>",
            refreshToken: "<yourrefreshtoken>"
        ))
    }
}
