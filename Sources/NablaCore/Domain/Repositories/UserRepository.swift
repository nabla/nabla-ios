import Foundation

// sourcery: AutoMockable
public protocol UserRepository {
    func getCurrentUser() -> User?
    func setCurrentUser(_ user: User?)
}
