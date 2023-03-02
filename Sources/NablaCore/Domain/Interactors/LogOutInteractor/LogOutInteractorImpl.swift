import Foundation

final class LogOutInteractorImpl: LogOutInteractor {
    // MARK: - Internal
    
    func execute() async {
        userRepository.setCurrentUser(nil)
        authenticator.logOut()
        scopedKeyValueStore.clear()
        extraActions.forEach { $0() }
        do {
            try await gqlStore.clearCache()
        } catch {
            logger.error(message: "Failed to clear cache on logout", error: error)
        }
    }
    
    func addAction(_ action: @escaping () -> Void) {
        extraActions.append(action)
    }
    
    // MARK: - Initializer
    
    init(
        userRepository: UserRepository,
        authenticator: Authenticator,
        gqlStore: GQLStore,
        scopedKeyValueStore: KeyValueStore,
        logger: Logger,
        errorReporter: ErrorReporter
    ) {
        self.userRepository = userRepository
        self.authenticator = authenticator
        self.gqlStore = gqlStore
        self.scopedKeyValueStore = scopedKeyValueStore
        self.logger = logger
        self.errorReporter = errorReporter
    }
    
    // MARK: - Private
    
    private let userRepository: UserRepository
    private let authenticator: Authenticator
    private let gqlStore: GQLStore
    private let scopedKeyValueStore: KeyValueStore
    private let logger: Logger
    private let errorReporter: ErrorReporter
    
    private var extraActions = [() -> Void]()
}
