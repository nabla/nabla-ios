import Foundation

class Session {
    // MARK: - Internal
    
    let userId: UUID
    let provider: SessionTokenProvider
    var authTokens: AuthTokens?
    
    init(
        userId: UUID,
        provider: SessionTokenProvider,
        authTokens: AuthTokens?
    ) {
        self.userId = userId
        self.provider = provider
        self.authTokens = authTokens
    }
    
    // MARK: - Private
}
