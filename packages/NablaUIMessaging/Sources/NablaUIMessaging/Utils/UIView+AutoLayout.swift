import UIKit

public extension UIView {
    func pinToSuperView(edges: UIRectEdge = .all, insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        guard let superview = self.superview else { return }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            edges.contains(.top) ? topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).with(priority: priority) : nil,
            edges.contains(.bottom) ? bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).with(priority: priority) : nil,
            edges.contains(.left) ? leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left).with(priority: priority) : nil,
            edges.contains(.right) ? rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right).with(priority: priority) : nil,
        ].compactMap { $0 })
    }

    func constraintToSize(_ size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width),
        ])
    }
}

public extension NSLayoutConstraint {
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
