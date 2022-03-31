import UIKit

public extension UIEdgeInsets {
    static func all(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(all: value)
    }

    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    static func horizontal(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(horizontal: value)
    }

    static func vertical(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(vertical: value)
    }

    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }

    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    var horizontal: CGFloat {
        left + right
    }

    var vertical: CGFloat {
        top + bottom
    }
}
