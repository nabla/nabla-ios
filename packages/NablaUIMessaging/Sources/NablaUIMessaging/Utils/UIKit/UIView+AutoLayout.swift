import UIKit

enum Relation {
    case equal, greaterThanOrEqual, lessThanOrEqual
}

extension NSLayoutDimension {
    func constraint(toConstant constant: CGFloat, relation: Relation = .equal) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: constant)
        }
    }
}

extension UIView {
    @discardableResult
    func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func pinToSuperView(edges: NSDirectionalRectEdge = .all, insets: NSDirectionalEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        guard let superview = superview else { return }

        prepareForAutoLayout()

        NSLayoutConstraint.activate([
            edges.contains(.top) ? topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).with(priority: priority) : nil,
            edges.contains(.bottom) ? bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).with(priority: priority) : nil,
            edges.contains(.leading) ? leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.leading).with(priority: priority) : nil,
            edges.contains(.trailing) ? trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.trailing).with(priority: priority) : nil,
        ].compactMap { $0 })
    }

    func center(in view: UIView) {
        prepareForAutoLayout()

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    func centerInSuperView() {
        guard let superview = superview else { return }

        center(in: superview)
    }

    func constraintToSize(_ size: CGSize) {
        constraintHeight(size.height)
        constraintWidth(size.width)
    }

    func constraintHeight(_ height: CGFloat, relation: Relation = .equal) {
        prepareForAutoLayout()
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(toConstant: height, relation: relation),
        ])
    }

    func constraintWidth(_ width: CGFloat, relation _: Relation = .equal) {
        prepareForAutoLayout()

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
        ])
    }
}

public extension NSLayoutConstraint {
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
