import Combine
import Foundation

protocol UserLocalDataSource {
    func getCurrentUser() -> LocalUser?
    func setCurrentUser(_ user: LocalUser?)
    func watchCurrentUser() -> AnyPublisher<LocalUser?, Never>
}
