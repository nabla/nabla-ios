import Combine
import Foundation

open class AuthenticatedInteractor {
    // MARK: - Public

    public var isAuthenticated: AnyPublisher<Void, NablaError> {
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
    public func assertIsAuthenticated() throws {
        if authenticator.currentUserId == nil {
            throw UserIdNotSetError()
        }
    }
    
    // MARK: Init
    
    public init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }

    // MARK: - Private

    private let authenticator: Authenticator
}
