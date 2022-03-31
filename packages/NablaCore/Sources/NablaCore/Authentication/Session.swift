import Foundation

class Session {
    // MARK: - Internal

    let userID: UUID
    var tokens: Tokens

    init(
        userID: UUID,
        tokens: Tokens
    ) {
        self.userID = userID
        self.tokens = tokens
    }

    // MARK: - Private
}
