import Foundation

// sourcery: AutoMockable
protocol KeyValueStore {
    func set<T: Codable>(_ object: T, forKey key: String) throws
    func get<T: Codable>(forKey key: String) throws -> T?
    func clear()
}
