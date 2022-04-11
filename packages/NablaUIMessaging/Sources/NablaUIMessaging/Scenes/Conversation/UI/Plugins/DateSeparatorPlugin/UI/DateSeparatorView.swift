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

    private var presenter: Presenter!

    private let label: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
}

extension DateSeparatorView: ReusableView {
    func configure(presenter: DateSeparatorPresenter) {
        self.presenter = presenter
        presenter.start()
    }

    func prepareForReuse() {
        label.text = nil
    }
}

extension DateSeparatorView: DateSeparatorViewContract {
    func configure(content: DateSeparatorItemContent) {
        label.text = content.text
    }
}

#if DEBUG
    import SwiftUI

    struct DateSeparatorView_Previews: PreviewProvider {
        static var preview: DateSeparatorView {
            let view = DateSeparatorView()
            view.configure(content: .init(text: "Hello DateSeparator"))
            return view
        }

        static var previews: some View {
            UIViewPreview {
                preview
            }
            .previewLayout(.fixed(width: 300, height: 44))
        }
    }
#endif
