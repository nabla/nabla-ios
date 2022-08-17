import UIKit

public extension NablaExtension where Base: UITableView {
    func reload(animated: Bool) {
        base.reloadSections(IndexSet(integer: 0), with: animated ? .automatic : .none)
    }
}
