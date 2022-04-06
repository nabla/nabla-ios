import UIKit

protocol ReusableView: UIView {
    associatedtype Data

    func configure(with data: Data)
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

    func configure(with data: HostedView.Data) {
        hostedView.configure(with: data)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        hostedView.prepareForReuse()
    }
    
    // MARK: - Private

    private let hostedView: HostedView = .init().prepareForAutoLayout()
}
