import UIKit

extension NSDirectionalEdgeInsets: NablaExtendable {}

public extension NablaExtension where Base == NSDirectionalEdgeInsets {
    static func all(_ value: CGFloat) -> Base {
        Base(top: value, leading: value, bottom: value, trailing: value)
    }
    
    static func horizontal(_ value: CGFloat) -> Base {
        make(horizontal: value)
    }
    
    static func vertical(_ value: CGFloat) -> Base {
        make(vertical: value)
    }
    
    static func only(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Base {
        Base(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
    
    static func make(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> Base {
        Base(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    var horizontal: CGFloat {
        base.leading + base.trailing
    }
    
    var vertical: CGFloat {
        base.top + base.bottom
    }
}
