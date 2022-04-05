import Foundation
import UIKit

final class ErrorView: UIView {
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)

        let label = UILabel()
        label.text = "ErrorView"
        label.textAlignment = .center
        addSubview(label)
        label.pinToSuperView(insets: .all(20))
    }
}
