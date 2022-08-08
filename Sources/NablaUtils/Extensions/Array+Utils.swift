import Foundation

public extension Array {
    func toDictionary<Key: Hashable>(_ keyPath: KeyPath<Element, Key>) -> [Key: Element] {
        var dictionary = [Key: Element]()
        for element in self {
            dictionary[element[keyPath: keyPath]] = element
        }
        return dictionary
    }
    
    func sorted<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { lhs, rhs in
            lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }
    
    mutating func sort<T: Comparable>(_ keyPath: KeyPath<Element, T>, using compare: (T, T) -> Bool) {
        sort { lhs, rhs in
            compare(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
        }
    }
}
