import Foundation
import NablaCore

class FakeAuthenticator: SessionTokenProvider {
    func provideTokens(forUserId _: String, completion: (AuthTokens?) -> Void) {
        // Emulate a call to authenticate the user on your server
        // In your app, you need to replace this with an actual call to your backend to get fresh tokens
        completion(.init(
            accessToken: "<youraccesstoken>",
            refreshToken: "<yourrefreshtoken>"
        ))
    }
}
