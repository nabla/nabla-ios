import Combine
import Foundation

class UserLocalDataSourceImpl: UserLocalDataSource {
    // MARK: - Internal
    
    func getCurrentUser() -> LocalUser? {
        currentUser.value
    }
    
    func setCurrentUser(_ user: LocalUser?) {
        currentUser.send(user)
    }
    
    func watchCurrentUser() -> AnyPublisher<LocalUser?, Never> {
        currentUser.eraseToAnyPublisher()
    }
    
    init(
        logger: Logger,
        store: KeyValueStore
    ) {
        self.logger = logger
        self.store = store
        do {
            currentUser = .init(try store.get(forKey: Constants.currentUserStoreKey))
        } catch {
            logger.error(message: "Failed to retrieve current user", error: error)
            currentUser = .init(nil)
        }
        synchronizeCurrentUser()
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let currentUserStoreKey = "currentUser_v2"
    }
    
    private let logger: Logger
    private let store: KeyValueStore
    private let currentUser: CurrentValueSubject<LocalUser?, Never>
    
    private var currentUserObserver: Cancellable?
    
    private func synchronizeCurrentUser() {
        currentUserObserver = currentUser.sink { [store, logger] user in
            do {
                try store.set(user, forKey: Constants.currentUserStoreKey)
            } catch {
                logger.error(message: "Failed to save current user", error: error)
            }
        }
    }
}
