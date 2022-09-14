import Foundation

public extension NablaExtension where Base: Collection {
    func element(at index: Base.Index) -> Base.Element? {
        base.indices.contains(index) ? base[index] : nil
    }
}
