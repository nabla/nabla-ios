import Foundation
import UIKit

public extension NablaExtension where Base: UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = base.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    
    func removeSubviews() {
        base.subviews.forEach { $0.removeFromSuperview() }
    }
}
