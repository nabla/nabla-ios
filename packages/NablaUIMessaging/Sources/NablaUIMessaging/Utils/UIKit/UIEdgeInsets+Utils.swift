import UIKit

extension UIEdgeInsets {
    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }

    static func all(_ value: CGFloat) -> Self {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
