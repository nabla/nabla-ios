import Combine
import Foundation

class UserRepositoryImpl: UserRepository {
    // MARK: - Initializer

    init(localDataSource: UserLocalDataSource) {
        self.localDataSource = localDataSource
    }

    // MARK: - Internal
    
    func getCurrentUser() -> User? {
        guard let user = localDataSource.getCurrentUser() else { return nil }
        return Self.transform(user)
    }
    
    func setCurrentUser(_ user: User?) {
        if let user = user {
            localDataSource.setCurrentUser(Self.transform(user))
        } else {
            localDataSource.setCurrentUser(nil)
        }
    }
    
    func watchCurrentUser() -> AnyPublisher<User?, Never> {
        localDataSource.watchCurrentUser()
            .map { user in
                if let user = user {
                    return Self.transform(user)
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let localDataSource: UserLocalDataSource
    
    private static func transform(_ user: User) -> LocalUser {
        LocalUser(
            id: user.id
        )
    }
    
    private static func transform(_ user: LocalUser) -> User {
        User(
            id: user.id
        )
    }
}
