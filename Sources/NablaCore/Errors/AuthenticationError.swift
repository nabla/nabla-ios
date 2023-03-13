import Foundation

public class AuthenticationError: NablaError {}

public class CurrentUserAlreadySetError: AuthenticationError {}

public class AuthenticationInternalError: NablaError {
    public let message: String
    
    init(message: String) {
        self.message = message
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["message": message], uniquingKeysWith: { _, rhs in rhs })
    }
}

public class UserIdNotSetError: AuthenticationError {}

public class AuthenticationProviderFailedToProvideTokensError: AuthenticationError {}

public class AuthenticationProviderDidProvideInvalidTokensError: AuthenticationError {
    public let reason: Error
    
    init(reason: Error) {
        self.reason = reason
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["reason": reason], uniquingKeysWith: { _, rhs in rhs })
    }
}

public class AuthenticationProviderDidProvideExpiredTokensError: AuthenticationError {}

public class AuthorizationDeniedError: AuthenticationError {
    public let reason: Error
    
    init(reason: Error) {
        self.reason = reason
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["reason": reason], uniquingKeysWith: { _, rhs in rhs })
    }
}

public class FailedToRefreshTokensError: AuthenticationError {
    public let reason: Error
    
    init(reason: Error) {
        self.reason = reason
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["reason": reason], uniquingKeysWith: { _, rhs in rhs })
    }
}

public class UnknownAuthenticationError: AuthenticationError {
    public let underlyingError: Error
    
    init(underlyingError: Error) {
        self.underlyingError = underlyingError
    }
    
    override public func serialize() -> [String: Any] {
        super.serialize().merging(["underlyingError": underlyingError], uniquingKeysWith: { _, rhs in rhs })
    }
}
