import Foundation

final class LogOutInteractorImpl: LogOutInteractor {
    // MARK: - Internal
    
    func execute() {
        userRepository.setCurrentUser(nil)
        authenticator.logOut()
        gqlStore.clearCache { [logger] result in
            switch result {
            case .success:
                break
            case let .failure(error):
                logger.error(message: "Failed to clear cache on logout", extra: ["reason": error])
            }
        }
        extraActions.forEach { $0() }
    }
    
    func addAction(_ action: @escaping () -> Void) {
        extraActions.append(action)
    }
    
    // MARK: - Initializer
    
    init(
        userRepository: UserRepository,
        authenticator: Authenticator,
        gqlStore: GQLStore,
        logger: Logger
    ) {
        self.userRepository = userRepository
        self.authenticator = authenticator
        self.gqlStore = gqlStore
        self.logger = logger
    }
    
    // MARK: - Private
    
    private let userRepository: UserRepository
    private let authenticator: Authenticator
    private let gqlStore: GQLStore
    private let logger: Logger
    
    private var extraActions = [() -> Void]()
}
