import Foundation

struct Session {
    // MARK: - Internal
    
    let userId: String
    let provider: SessionTokenProvider
    var tokens: SessionTokens?
    
    func with(tokens: SessionTokens) -> Session {
        .init(userId: userId, provider: provider, tokens: tokens)
    }
    
    // MARK: - Private
}
