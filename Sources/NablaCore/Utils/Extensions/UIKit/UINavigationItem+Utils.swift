import UIKit

public extension NablaExtension where Base == UINavigationItem {
    func addRightBarButtonItem(_ button: UIBarButtonItem) {
        if base.rightBarButtonItems != nil {
            base.rightBarButtonItems?.append(button)
        } else {
            base.rightBarButtonItems = [button]
        }
    }

    func addLeftBarButtonItem(_ button: UIBarButtonItem) {
        if base.leftBarButtonItems != nil {
            base.leftBarButtonItems?.append(button)
        } else {
            base.leftBarButtonItems = [button]
        }
    }
}
