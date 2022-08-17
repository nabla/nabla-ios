import UIKit

public extension NablaExtension where Base: Reusable {
    static var reusableIdentifier: String {
        String(reflecting: self)
    }
}

public extension NablaExtension where Base: UITableView {
    func register<Cell: UITableViewCell>(_ reusableCellClass: Cell.Type) where Cell: Reusable {
        base.register(reusableCellClass, forCellReuseIdentifier: reusableCellClass.nabla.reusableIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(ofClass reusableCellClass: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: Reusable {
        if let cell = base.dequeueReusableCell(withIdentifier: reusableCellClass.nabla.reusableIdentifier, for: indexPath) as? Cell {
            return cell
        }
        fatalError("You forgot to register \(Cell.self) as reusable cell.")
    }
}

public extension NablaExtension where Base: UICollectionView {
    func register<Cell: UICollectionViewCell>(_ reusableCellClass: Cell.Type) where Cell: Reusable {
        base.register(reusableCellClass, forCellWithReuseIdentifier: reusableCellClass.nabla.reusableIdentifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(ofClass reusableCellClass: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: Reusable {
        if let cell = base.dequeueReusableCell(withReuseIdentifier: reusableCellClass.nabla.reusableIdentifier, for: indexPath) as? Cell {
            return cell
        }
        fatalError("You forgot to register \(Cell.self) as reusable cell.")
    }
}
