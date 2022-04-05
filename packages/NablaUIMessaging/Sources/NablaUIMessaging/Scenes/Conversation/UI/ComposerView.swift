import Foundation
import UIKit

final class ComposerView: UIView {
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)

        backgroundColor = CoreAssets.Colors.tint.color
        let field = UITextField()
        field.constraintHeight(44)
        addSubview(field)
        field.pinToSuperView(insets: .init(horizontal: 20, vertical: 4))
    }
}
