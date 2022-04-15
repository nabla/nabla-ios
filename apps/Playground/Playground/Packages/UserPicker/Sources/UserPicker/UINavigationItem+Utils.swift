import UIKit

extension UINavigationItem {
    func addRightBarButtonItem(_ button: UIBarButtonItem) {
        if rightBarButtonItems != nil {
            rightBarButtonItems?.append(button)
        } else {
            rightBarButtonItems = [button]
        }
    }
    func addLeftBarButtonItem(_ button: UIBarButtonItem) {
        if leftBarButtonItems != nil {
            leftBarButtonItems?.append(button)
        } else {
            leftBarButtonItems = [button]
        }
    }
}
