import Foundation

class Session {
    // MARK: - Internal
    
    let userId: String
    let provider: SessionTokenProvider
    var authTokens: AuthTokens?
    
    init(
        userId: String,
        provider: SessionTokenProvider,
        authTokens: AuthTokens?
    ) {
        self.userId = userId
        self.provider = provider
        self.authTokens = authTokens
    }
    
    // MARK: - Private
}
