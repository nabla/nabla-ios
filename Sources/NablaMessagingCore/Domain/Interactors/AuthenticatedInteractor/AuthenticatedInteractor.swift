import Foundation
import NablaCore

class AuthenticatedInteractor {
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }

    final var isAuthenticated: Bool {
        authenticator.isSessionInitialized()
    }

    // MARK: - Private

    private let authenticator: Authenticator
}
