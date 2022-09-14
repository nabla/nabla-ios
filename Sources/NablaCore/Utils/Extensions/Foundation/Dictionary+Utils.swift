import Foundation

public extension Dictionary {
    var nabla: NablaDictionaryExtension<Key, Value> {
        NablaDictionaryExtension(base: self)
    }
}

public struct NablaDictionaryExtension<Key: Hashable, Value> {
    let base: [Key: Value]
}

public extension NablaDictionaryExtension {
    func sortedByKeys<T: Comparable>(_ keyPath: KeyPath<Key, T>) -> [(Key, Value)] {
        base.sorted { lhs, rhs in
            lhs.key[keyPath: keyPath] < rhs.key[keyPath: keyPath]
        }
    }
    
    func sortedByKeys<T: Comparable>(_ keyPath: KeyPath<Key, T>, using compare: (T, T) -> Bool) -> [(Key, Value)] {
        base.sorted { lhs, rhs in
            compare(lhs.key[keyPath: keyPath], rhs.key[keyPath: keyPath])
        }
    }
}

public extension NablaDictionaryExtension where Key: Comparable {
    func sortedByKeys() -> [(Key, Value)] {
        sortedByKeys(\.self)
    }
    
    func sortedByKeys(using compare: (Key, Key) -> Bool) -> [(Key, Value)] {
        sortedByKeys(\.self, using: compare)
    }
}
