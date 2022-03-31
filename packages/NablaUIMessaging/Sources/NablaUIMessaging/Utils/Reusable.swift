import MapKit
import UIKit

public protocol Reusable {}

public extension Reusable where Self: UITableViewCell {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

public extension UITableView {
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

public extension Reusable where Self: MKAnnotationView {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

public extension MKMapView {
    func register<View: MKAnnotationView>(_ reusableViewClass: View.Type) where View: Reusable {
        register(reusableViewClass, forAnnotationViewWithReuseIdentifier: reusableViewClass.reusableIdentifier)
    }
    
    func dequeueReusableAnnotationView<View: MKAnnotationView>(ofClass reusableViewClass: View.Type, for annotation: MKAnnotation) -> View where View: Reusable {
        if let view = dequeueReusableAnnotationView(withIdentifier: reusableViewClass.reusableIdentifier, for: annotation) as? View {
            return view
        }
        return reusableViewClass.init(annotation: annotation, reuseIdentifier: reusableViewClass.reusableIdentifier)
    }
}

public extension Reusable where Self: UICollectionViewCell {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

public extension UICollectionView {
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
