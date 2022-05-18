import Foundation
import NablaUtils

class UserLocalDataSourceImpl: UserLocalDataSource {
    // MARK: - Internal
    
    func getCurrentUser() -> LocalUser? {
        do {
            return try store.get(forKey: Constants.currentUserStoreKey)
        } catch {
            logger.error(message: "Failed to retrieve current user: \(error)")
            return nil
        }
    }
    
    func setCurrentUser(_ user: LocalUser?) {
        do {
            try store.set(user, forKey: Constants.currentUserStoreKey)
        } catch {
            logger.error(message: "Failed to save current user: \(error)")
        }
    }
    
    init(
        logger: Logger,
        store: KeyValueStore
    ) {
        self.logger = logger
        self.store = store
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let currentUserStoreKey = "currentUser"
    }
    
    private let logger: Logger
    
    private let store: KeyValueStore
}
