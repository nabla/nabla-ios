import UIKit

extension NSDirectionalEdgeInsets {
    static func all(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        .init(all: value)
    }

    static func horizontal(_ value: CGFloat) -> Self {
        .init(horizontal: value)
    }

    static func vertical(_ value: CGFloat) -> Self {
        .init(vertical: value)
    }

    static func only(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Self {
        self.init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    init(all value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }

    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    var horizontal: CGFloat {
        leading + trailing
    }

    var vertical: CGFloat {
        top + bottom
    }
}
