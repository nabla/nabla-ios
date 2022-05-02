import UIKit

extension UITableView {
    func reload(animated: Bool) {
        reloadSections(IndexSet(integer: 0), with: animated ? .automatic : .none)
    }
}
