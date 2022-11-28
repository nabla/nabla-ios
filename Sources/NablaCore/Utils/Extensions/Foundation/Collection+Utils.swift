import Foundation

extension Array: NablaExtendable {}
extension Dictionary.Values: NablaExtendable {}

public extension NablaExtension where Base: Collection {
    func element(at index: Base.Index) -> Base.Element? {
        base.indices.contains(index) ? base[index] : nil
    }
    
    func toDictionary<Key: Hashable>(_ keyPath: KeyPath<Base.Element, Key>) -> [Key: Base.Element] {
        var dictionary = [Key: Base.Element]()
        for element in base {
            dictionary[element[keyPath: keyPath]] = element
        }
        return dictionary
    }
    
    func toGroups<Key: Hashable>(_ keyPath: KeyPath<Base.Element, Key>) -> [Key: [Base.Element]] {
        var dictionary = [Key: [Base.Element]]()
        for element in base {
            let key = element[keyPath: keyPath]
            var group = dictionary[key] ?? []
            group.append(element)
            dictionary[key] = group
        }
        return dictionary
    }
    
    func sorted<T: Comparable>(_ keyPath: KeyPath<Base.Element, T>) -> [Base.Element] {
        base.sorted { lhs, rhs in
            lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }
    
    func sorted<T: Comparable>(_ keyPath: KeyPath<Base.Element, T>, using compare: (T, T) -> Bool) -> [Base.Element] {
        base.sorted { lhs, rhs in
            compare(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
        }
    }
}
