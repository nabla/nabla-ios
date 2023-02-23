import Foundation

struct Session {
    // MARK: - Internal
    
    let userId: String
    var tokens: SessionTokens?
    
    func with(tokens: SessionTokens) -> Session {
        .init(userId: userId, tokens: tokens)
    }
    
    // MARK: - Private
}
