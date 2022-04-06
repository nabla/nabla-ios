import UIKit

final class DateSeparatorView: UIView {
    // MARK: - Init

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)

        addSubview(label)
        label.pinToSuperView(insets: .init(horizontal: 20, vertical: 4))
        label.backgroundColor = .green
    }

    // MARK: - Private

    private let label: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
}

extension DateSeparatorView: ReusableView {
    func configure(with content: DateSeparatorItemContent) {
        label.text = content.text
    }

    func prepareForReuse() {
        label.text = nil
    }
}
