import Foundation
import NablaUtils

class UserRepositoryImpl: UserRepository {
    // MARK: - Internal
    
    func getCurrentUser() -> User? {
        guard let user = localDataSource.getCurrentUser() else { return nil }
        return transform(user)
    }
    
    func setCurrentUser(_ user: User?) {
        guard let user = user else { return }
        localDataSource.setCurrentUser(transform(user))
    }
    
    // MARK: - Private
    
    @Inject private var localDataSource: UserLocalDataSource
    
    private func transform(_ user: User) -> LocalUser {
        LocalUser(
            id: user.id
        )
    }
    
    private func transform(_ user: LocalUser) -> User {
        User(
            id: user.id
        )
    }
}
