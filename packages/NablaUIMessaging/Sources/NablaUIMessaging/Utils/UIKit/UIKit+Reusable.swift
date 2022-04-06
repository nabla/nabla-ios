import UIKit

extension Reusable where Self: UITableViewCell {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func register<Cell: UITableViewCell>(_ reusableCellClass: Cell.Type) where Cell: Reusable {
        register(reusableCellClass, forCellReuseIdentifier: reusableCellClass.reusableIdentifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(ofClass reusableCellClass: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: Reusable {
        if let cell = dequeueReusableCell(withIdentifier: reusableCellClass.reusableIdentifier, for: indexPath) as? Cell {
            return cell
        }
        return reusableCellClass.init()
    }
}

extension Reusable where Self: UICollectionViewCell {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_ reusableCellClass: Cell.Type) where Cell: Reusable {
        register(reusableCellClass, forCellWithReuseIdentifier: reusableCellClass.reusableIdentifier)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(ofClass reusableCellClass: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: Reusable {
        if let cell = dequeueReusableCell(withReuseIdentifier: reusableCellClass.reusableIdentifier, for: indexPath) as? Cell {
            return cell
        }
        return reusableCellClass.init()
    }
}
