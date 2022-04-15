import Foundation

final class UserRepository {
    // MARK: - Internal
    
    func getUsers() -> [User] {
        do {
            guard let data = store.object(forKey: Constants.usersKey) as? Data else { return [] }
            let decoder = JSONDecoder()
            return try decoder.decode([User].self, from: data)
        } catch {
            print("Failed to read persisted users: \(error)")
            return []
        }
    }
    
    func persist(user: User) {
        var users = getUsers()
        users.append(user)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(users)
            store.set(data, forKey: Constants.usersKey)
        } catch {
            print("Failed to persist users: \(error)")
        }
    }
    
    // MARK: - Private
    
    private let store = UserDefaults.standard
    
    private enum Constants {
        static let usersKey = "UserRepository.users"
    }
}
