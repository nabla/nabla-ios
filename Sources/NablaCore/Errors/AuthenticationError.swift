import Foundation

public class AuthenticationError: NablaError {}

public class MissingAuthenticationProviderError: AuthenticationError {}

public class AuthenticationProviderFailedToProvideTokensError: AuthenticationError {}

public class AuthenticationProviderDidProvideInvalidTokensError: AuthenticationError {
    public let reason: Error
    
    init(reason: Error) {
        self.reason = reason
    }
}

public class AuthenticationProviderDidProvideExpiredTokensError: AuthenticationError {}

public class AuthorizationDeniedError: AuthenticationError {
    public let reason: Error
    
    init(reason: Error) {
        self.reason = reason
    }
}

public class FailedToRefreshTokensError: AuthenticationError {
    public let reason: Error
    
    init(reason: Error) {
        self.reason = reason
    }
}

public class UnknownAuthenticationError: AuthenticationError {
    public let undelryingError: Error
    
    init(undelryingError: Error) {
        self.undelryingError = undelryingError
    }
}
