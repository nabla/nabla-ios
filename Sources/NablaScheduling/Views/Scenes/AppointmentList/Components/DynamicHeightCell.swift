import UIKit

class DynamicHeightCell: UITableViewCell {
    // MARK: - Internal
    
    func setNeedsHeightUpdate() {
        DispatchQueue.main.async { [tableView] in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
    }
    
    // MARK: - Private
    
    private var tableView: UITableView? {
        var view = superview
        while let superView = view {
            if let tableView = superView as? UITableView {
                return tableView
            }
            view = superView
        }
        return nil
    }
}
