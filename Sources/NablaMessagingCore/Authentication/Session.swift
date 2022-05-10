import Foundation

class Session {
    // MARK: - Internal
    
    let userId: UUID
    var tokens: Tokens
    
    init(
        userId: UUID,
        tokens: Tokens
    ) {
        self.userId = userId
        self.tokens = tokens
    }
    
    // MARK: - Private
}
