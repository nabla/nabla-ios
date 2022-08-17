import UIKit

public enum Relation {
    case equal, greaterThanOrEqual, lessThanOrEqual
}

public protocol LayoutGuide {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: LayoutGuide {}
extension UIView: LayoutGuide {}

public extension NablaExtension where Base: NSLayoutDimension {
    func constraint(toConstant constant: CGFloat, relation: Relation = .equal) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return base.constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            return base.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            return base.constraint(lessThanOrEqualToConstant: constant)
        }
    }
}

public extension NablaExtension where Base: UIView {
    @discardableResult
    func prepareForAutoLayout() -> Base {
        base.translatesAutoresizingMaskIntoConstraints = false
        return base
    }
    
    func pin(to guide: LayoutGuide, edges: NSDirectionalRectEdge = .all, insets: NSDirectionalEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        prepareForAutoLayout()
        
        NSLayoutConstraint.activate([
            edges.contains(.top)
                ? base.topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top).nabla.with(priority: priority)
                : nil,
            edges.contains(.bottom)
                ? base.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom).nabla.with(priority: priority)
                : nil,
            edges.contains(.leading)
                ? base.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: insets.leading).nabla.with(priority: priority)
                : nil,
            edges.contains(.trailing)
                ? base.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -insets.trailing).nabla.with(priority: priority)
                : nil,
        ].compactMap { $0 })
    }
    
    func pinToSuperView(edges: NSDirectionalRectEdge = .all, insets: NSDirectionalEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        guard let superview = base.superview else { return }
        pin(to: superview, edges: edges, insets: insets, priority: priority)
    }
    
    func constraintToCenter(in view: UIView, along axis: NSLayoutConstraint.Axis) {
        prepareForAutoLayout()

        switch axis {
        case .horizontal:
            NSLayoutConstraint.activate([base.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        case .vertical:
            NSLayoutConstraint.activate([base.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        @unknown default:
            break
        }
    }

    func constraintToCenter(in guide: LayoutGuide, offset: CGPoint = .zero, insets: CGPoint = .zero) {
        prepareForAutoLayout()

        NSLayoutConstraint.activate([
            base.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: offset.x),
            base.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: offset.y),
            base.topAnchor.constraint(greaterThanOrEqualTo: guide.topAnchor, constant: insets.y),
            base.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: insets.x),
        ])
    }
    
    func constraintToCenter(in guide: LayoutGuide, offset: CGPoint = .zero, insets: CGFloat) {
        constraintToCenter(in: guide, offset: offset, insets: .init(x: insets, y: insets))
    }
    
    func constraintToCenterInSuperView(along axis: NSLayoutConstraint.Axis) {
        guard let superview = base.superview else { return }
        constraintToCenter(in: superview, along: axis)
    }

    func constraintToCenterInSuperView(insets: CGPoint = .zero) {
        guard let superview = base.superview else { return }
        constraintToCenter(in: superview, insets: insets)
    }
    
    func constraintToSize(_ size: CGSize) {
        constraintHeight(size.height)
        constraintWidth(size.width)
    }
    
    func constraintToSize(_ size: CGFloat) {
        constraintToSize(CGSize(width: size, height: size))
    }
    
    func constraintHeight(_ height: CGFloat, relation: Relation = .equal) {
        prepareForAutoLayout()
        
        NSLayoutConstraint.activate([
            base.heightAnchor.nabla.constraint(toConstant: height, relation: relation),
        ])
    }
    
    func constraintWidth(_ width: CGFloat, relation: Relation = .equal) {
        prepareForAutoLayout()
        
        NSLayoutConstraint.activate([
            base.widthAnchor.nabla.constraint(toConstant: width, relation: relation),
        ])
    }
}

public extension NablaExtension where Base: NSLayoutConstraint {
    func with(priority: UILayoutPriority) -> Base {
        base.priority = priority
        return base
    }
}
