import Combine
import Foundation
import NablaCore

class AuthenticatedInteractor {
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }

    final var isAuthenticated: AnyPublisher<Void, NablaError> {
        authenticator.watchCurrentUserId()
            .removeDuplicates()
            .setFailureType(to: NablaError.self)
            .nabla.resultMap { userId in
                if userId == nil {
                    return .failure(UserIdNotSetError())
                } else {
                    return .success(())
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// - Throws: ``NablaError``
    func assertIsAuthenticated() throws {
        if authenticator.currentUserId == nil {
            throw UserIdNotSetError()
        }
    }

    // MARK: - Private

    private let authenticator: Authenticator
}
