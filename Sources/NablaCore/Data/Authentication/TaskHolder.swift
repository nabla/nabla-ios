import Foundation

/// Shares a single `Task` while it runs.
actor TaskHolder<T> {
    private var current: Task<T, Error>?
    
    func run(_ operation: @escaping @Sendable () async throws -> T) async throws -> T {
        if let current = current {
            return try await current.value
        }
        let task = Task {
            let value = try await operation()
            current = nil
            return value
        }
        current = task
        return try await task.value
    }
}
