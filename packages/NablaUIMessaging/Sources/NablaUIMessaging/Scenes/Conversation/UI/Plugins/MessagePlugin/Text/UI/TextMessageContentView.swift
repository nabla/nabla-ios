import Foundation
import UIKit

final class TextMessageContentView: UIView, MessageContentView {
    // MARK: - Init

    init() {
        super.init(frame: .zero)
        addSubview(label)
        label.pinToSuperView(insets: .init(horizontal: 16, vertical: 8))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - MessageContentView

    func configure(with viewModel: TextMessageContentViewModel, sender: ConversationMessageSender) {
        label.text = viewModel.text
        switch sender {
        case .me:
            label.textColor = NablaTheme.TextMessageContentView.meTextColor
        case .them:
            label.textColor = NablaTheme.TextMessageContentView.themTextColor
        }
    }

    func prepareForReuse() {
        label.text = nil
    }

    // MARK: - Private

    private lazy var label: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.numberOfLines = 0
        label.font = NablaTheme.TextMessageContentView.font
        return label
    }()
}
