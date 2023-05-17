import Combine
import Foundation

open class AuthenticatedInteractor {
    // MARK: - Public

    public var isAuthenticated: AnyPublisher<Void, NablaError> {
        userRepository.watchCurrentUser()
            .map { $0?.id }
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
        if userRepository.getCurrentUser() == nil {
            throw UserIdNotSetError()
        }
    }
    
    // MARK: Init
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    // MARK: - Private

    private let userRepository: UserRepository
}
