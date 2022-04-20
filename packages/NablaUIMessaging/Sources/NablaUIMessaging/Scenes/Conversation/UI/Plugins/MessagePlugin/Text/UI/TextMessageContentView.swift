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
            label.textColor = .white
        case .them:
            label.textColor = .black
        }
    }

    func prepareForReuse() {
        label.text = nil
    }

    // MARK: - Private

    private let label: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
}
