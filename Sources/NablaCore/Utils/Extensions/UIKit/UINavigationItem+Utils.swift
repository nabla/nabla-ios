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
    
    func insertRightBarButtonItem(_ button: UIBarButtonItem, at index: Int) {
        if let rightBarButtonItems = base.rightBarButtonItems {
            guard !rightBarButtonItems.contains(button) else { return }
            base.rightBarButtonItems?.insert(button, at: index)
        } else {
            base.rightBarButtonItems = [button]
        }
    }
    
    func insertLeftBarButtonItem(_ button: UIBarButtonItem, at index: Int) {
        if let leftBarButtonItems = base.leftBarButtonItems {
            guard !leftBarButtonItems.contains(button) else { return }
            base.leftBarButtonItems?.insert(button, at: index)
        } else {
            base.leftBarButtonItems = [button]
        }
    }
    
    func removeRightBarButtonItem(_ button: UIBarButtonItem) {
        if let index = base.rightBarButtonItems?.firstIndex(of: button) {
            base.rightBarButtonItems?.remove(at: index)
        }
    }
    
    func removeLeftBarButtonItem(_ button: UIBarButtonItem) {
        if let index = base.leftBarButtonItems?.firstIndex(of: button) {
            base.leftBarButtonItems?.remove(at: index)
        }
    }
}
