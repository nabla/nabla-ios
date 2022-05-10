import Foundation

protocol UserRepository {
    func getCurrentUser() -> User?
    func setCurrentUser(_ user: User?)
}
