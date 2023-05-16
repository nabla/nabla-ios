import Foundation

/// Shares a single `Task` while it runs.
actor TaskHolder<T> {
    private var current: Task<T, Error>?
    
    func run(_ operation: @escaping @Sendable () async throws -> T) async throws -> T {
        if let current = current {
            return try await current.value
        }
        let task = Task {
            do {
                let value = try await operation()
                current = nil
                return value
            } catch {
                current = nil
                throw error
            }
        }
        current = task
        return try await task.value
    }
}
