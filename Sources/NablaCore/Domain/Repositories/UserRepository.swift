import Foundation

public protocol UserRepository {
    func getCurrentUser() -> User?
    func setCurrentUser(_ user: User?)
}
