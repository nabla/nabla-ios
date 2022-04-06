import UIKit

final class EmptyView: UIView {
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)

        let label = UILabel()
        label.text = "EmptyView"
        label.textAlignment = .center
        addSubview(label)
        label.pinToSuperView(insets: .all(20))
    }
}
