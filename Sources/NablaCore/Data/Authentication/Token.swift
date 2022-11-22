import Foundation

struct Token: Equatable {
    let value: String
    let expiresAt: Date?
    
    var isExpired: Bool {
        expiresAt?.nabla.isPast ?? false
    }
}

struct SessionTokens: Equatable {
    let accessToken: Token
    let refreshToken: Token
}
