import Foundation
import UIKit

class ImageDetailViewController: UIViewController, ImageDetailViewContract {
    var presenter: ImageDetailPresenter?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.start()
    }

    // MARK: - ImageDetailViewContract

    func configure(with viewModel: ImageDetailViewModel) {
        imageView.url = viewModel.url
    }

    // MARK: - Private

    private lazy var imageView: UIURLImageView = makeImageView()

    private func setUp() {
        view.backgroundColor = NablaTheme.ImageDetailViewController.backgroundColor
        view.addSubview(imageView)
        imageView.pinToSuperView()
    }

    private func makeImageView() -> UIURLImageView {
        let imageView = UIURLImageView(frame: .zero)
        imageView.prepareForAutoLayout()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
