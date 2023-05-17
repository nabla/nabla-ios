import Foundation

final class SetCurrentUserInteractorImpl: SetCurrentUserInteractor {
    // MARK: - Internal
    
    func execute(userId: String) throws {
        if let previousUser = userRepository.getCurrentUser() {
            if previousUser.id == userId {
                logger.error(message: "User already authenticated.")
                return
            } else {
                logger.error(message: "Trying to authenticate a new user, you must clear the previous one first by calling `clearCurrentUser()`.")
                throw CurrentUserAlreadySetError()
            }
        }
        logger.info(message: "Setting a new current user.")
        userRepository.setCurrentUser(User(id: userId))
    }
    
    // MARK: Init
    
    init(
        userRepository: UserRepository,
        logger: Logger
    ) {
        self.userRepository = userRepository
        self.logger = logger
    }
    
    // MARK: - Private
    
    private let userRepository: UserRepository
    private let logger: Logger
}
