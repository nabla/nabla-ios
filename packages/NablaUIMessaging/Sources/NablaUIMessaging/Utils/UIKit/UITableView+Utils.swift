import UIKit

extension UITableView {
    func reload(animated _: Bool) {
        reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
