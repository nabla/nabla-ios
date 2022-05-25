import Foundation

class Session {
    // MARK: - Internal
    
    let userId: UUID
    let provider: SessionTokenProvider
    var tokens: Tokens?
    
    init(
        userId: UUID,
        provider: SessionTokenProvider,
        tokens: Tokens?
    ) {
        self.userId = userId
        self.provider = provider
        self.tokens = tokens
    }
    
    // MARK: - Private
}
