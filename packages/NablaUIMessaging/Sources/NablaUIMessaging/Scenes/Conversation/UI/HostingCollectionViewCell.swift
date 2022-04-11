import UIKit

protocol ReusableView: UIView {
    associatedtype Presenter

    func configure(presenter: Presenter)
    func prepareForReuse()
}

final class HostingCollectionViewCell<HostedView: ReusableView>: UICollectionViewCell, Reusable {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(hostedView)
        hostedView.pinToSuperView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    let hostedView: HostedView = .init().prepareForAutoLayout()

    func configure(presenter: HostedView.Presenter) {
        hostedView.configure(presenter: presenter)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        hostedView.prepareForReuse()
    }
}
