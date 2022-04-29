import Foundation

public protocol NablaAuthenticationProvider {
    func provideTokens(completion: (Tokens?) -> Void)
}
