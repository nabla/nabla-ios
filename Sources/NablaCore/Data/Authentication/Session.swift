import Foundation

class Session {
    // MARK: - Internal
    
    let userId: String
    let provider: SessionTokenProvider
    var tokens: SessionTokens?
    
    init(
        userId: String,
        provider: SessionTokenProvider,
        tokens: SessionTokens?
    ) {
        self.userId = userId
        self.provider = provider
        self.tokens = tokens
    }
    
    // MARK: - Private
}
