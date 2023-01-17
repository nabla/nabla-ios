import UIKit

extension UILayoutPriority: NablaExtendable {}

public extension NablaExtension where Base == UILayoutPriority {
    /// Priority for subviews of `UICollectionViewCell` or `UITableViewCell` whose frame is initialized with `.zero` when dequeued.
    /// Value is lower but almost equal to `.required`.
    static var cellContentPriority: UILayoutPriority {
        .init(UILayoutPriority.required.rawValue - 1)
    }
}
