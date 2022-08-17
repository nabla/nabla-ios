import UIKit

extension UIEdgeInsets: NablaExtendable {}

public extension NablaExtension where Base == UIEdgeInsets {
    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Base {
        Base(top: top, left: left, bottom: bottom, right: right)
    }
    
    static func all(_ value: CGFloat) -> Base {
        Base(top: value, left: value, bottom: value, right: value)
    }
    
    static func make(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> Base {
        Base(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
