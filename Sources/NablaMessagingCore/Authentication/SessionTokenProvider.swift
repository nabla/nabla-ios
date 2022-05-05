import Foundation

public protocol SessionTokenProvider {
    func provideTokens(completion: (Tokens?) -> Void)
}
