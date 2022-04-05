import Foundation
import UIKit

public extension UIEdgeInsets {
    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
}
