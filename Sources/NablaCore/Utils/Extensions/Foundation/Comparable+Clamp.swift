import Foundation

public extension NablaExtension where Base: Comparable {
    /// Clamp a value within the range
    func clamped(to limits: ClosedRange<Base>) -> Base {
        min(max(base, limits.lowerBound), limits.upperBound)
    }
}
