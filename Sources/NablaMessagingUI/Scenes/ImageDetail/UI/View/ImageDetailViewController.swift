import Foundation
import NablaCore
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

    private lazy var imageView: NablaViews.URLImageView = makeImageView()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.ImageDetail.backgroundColor
        view.addSubview(imageView)
        imageView.nabla.pinToSuperView()
    }
    
    private func makeImageView() -> NablaViews.URLImageView {
        let imageView = NablaViews.URLImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
