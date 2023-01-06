import Foundation

final class LogOutInteractorImpl: LogOutInteractor {
    // MARK: - Internal
    
    func execute() {
        userRepository.setCurrentUser(nil)
        authenticator.logOut()
        scopedKeyValueStore.clear()
        extraActions.forEach { $0() }
        Task {
            do {
                try await gqlStore.clearCache()
            } catch {
                logger.error(message: "Failed to clear cache on logout", extra: ["reason": error])
            }
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
        logger: Logger
    ) {
        self.userRepository = userRepository
        self.authenticator = authenticator
        self.gqlStore = gqlStore
        self.scopedKeyValueStore = scopedKeyValueStore
        self.logger = logger
    }
    
    // MARK: - Private
    
    private let userRepository: UserRepository
    private let authenticator: Authenticator
    private let gqlStore: GQLStore
    private let scopedKeyValueStore: KeyValueStore
    private let logger: Logger
    
    private var extraActions = [() -> Void]()
}
