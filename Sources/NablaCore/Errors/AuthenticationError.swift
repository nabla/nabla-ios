import Foundation

public class AuthenticationError: NablaError {}

public class MissingAuthenticationProviderError: AuthenticationError {}

public class AuthenticationProviderFailedToProvideTokensError: AuthenticationError {}

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
