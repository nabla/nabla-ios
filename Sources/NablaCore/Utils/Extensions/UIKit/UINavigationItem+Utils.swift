import UIKit

public extension NablaExtension where Base == UINavigationItem {
    func addRightBarButtonItem(_ button: UIBarButtonItem) {
        if let rightBarButtonItems = base.rightBarButtonItems {
            guard !rightBarButtonItems.contains(button) else { return }
            base.rightBarButtonItems?.append(button)
        } else {
            base.rightBarButtonItems = [button]
        }
    }

    func addLeftBarButtonItem(_ button: UIBarButtonItem) {
        if let leftBarButtonItems = base.leftBarButtonItems {
            guard !leftBarButtonItems.contains(button) else { return }
            base.leftBarButtonItems?.append(button)
        } else {
            base.leftBarButtonItems = [button]
        }
    }
}
