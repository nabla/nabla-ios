import UIKit

public extension UIView {
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

    func constraintToSize(_ size: CGSize) {
        prepareForAutoLayout()

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width),
        ])
    }

    func constraintHeight(_ height: CGFloat) {
        prepareForAutoLayout()

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
        ])
    }
}

public extension NSLayoutConstraint {
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
