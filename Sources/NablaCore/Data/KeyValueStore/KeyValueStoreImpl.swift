import Foundation

class KeyValueStoreImpl: KeyValueStore {
    // MARK: - Internal
    
    func set<T: Codable>(_ object: T?, forKey key: String) throws {
        defer {
            userDefaults.synchronize()
        }
        guard let object = object else {
            userDefaults.removeObject(forKey: key)
            return
        }
        let data = try JSONEncoder().encode(object)
        userDefaults.set(data, forKey: format(key: key))
    }
    
    func get<T: Codable>(forKey key: String) throws -> T? {
        guard let data = userDefaults.object(forKey: format(key: key)) as? Data else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func clear() {
        userDefaults.dictionaryRepresentation().forEach { key, _ in
            guard key.hasPrefix(keyPrefix) else { return }
            userDefaults.removeObject(forKey: key)
        }
    }
    
    func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    init(
        namespace: String,
        userDefaults: UserDefaults = .standard
    ) {
        self.namespace = namespace
        self.userDefaults = userDefaults
    }
    
    // MARK: - Private
    
    private let namespace: String
    private let userDefaults: UserDefaults
    
    private var keyPrefix: String {
        "com.nabla.sdk.\(namespace)"
    }
    
    private func format(key: String) -> String {
        "\(keyPrefix).\(key)"
    }
}
