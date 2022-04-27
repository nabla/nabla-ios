import Foundation
import UIKit

protocol HasMoreIndicatorViewContract: AnyObject {}

final class HasMoreIndicatorCell: UICollectionViewCell, Reusable, HasMoreIndicatorViewContract {
    // MARK: - Init
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUpSubviews()
    }
    
    func configure(presenter: HasMoreIndicatorPresenter) {
        self.presenter = presenter
    }

    // MARK: - Private
    
    private var presenter: HasMoreIndicatorPresenter?

    private let loadingIndicatorView: UIView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = NablaTheme.LoadingView.tintColor
        view.startAnimating()
        return view
    }()
    
    private func setUpSubviews() {
        guard contentView.subviews.isEmpty else { return }
        contentView.addSubview(loadingIndicatorView)
        loadingIndicatorView.pinToSuperView(insets: .init(all: 8))
    }
}
