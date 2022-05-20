import Foundation

class AuthenticatedInteractor {
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }

    final func isAuthenticated<Data>(handler: ResultHandler<Data, NablaError>) -> Bool {
        if !authenticator.isSessionInitialized() {
            handler(.failure(.authenticationError(.missingAuthenticationProvider)))
            return false
        }
        return true
    }

    // MARK: - Private

    private let authenticator: Authenticator
}
