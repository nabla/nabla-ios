import Foundation
import LinkPresentation
import NablaCore
import UIKit

final class ImageDetailViewController: UIViewController, ImageDetailViewContract {
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
        fileName = viewModel.fileName
    }
    
    // MARK: - Private
    
    private var fileName: String?
    
    private lazy var imageView: NablaViews.URLImageView = makeImageView()
    
    private func setUp() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareAction)
        )
        view.backgroundColor = NablaTheme.ImageDetail.backgroundColor
        view.addSubview(imageView)
        imageView.nabla.pinToSuperView()
    }
    
    private func makeImageView() -> NablaViews.URLImageView {
        let imageView = NablaViews.URLImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    @objc private func shareAction() {
        guard let image = imageView.image else {
            return
        }
        present(
            UIActivityViewController(activityItems: [image, self], applicationActivities: nil),
            animated: true
        )
    }
}

extension ImageDetailViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_: UIActivityViewController) -> Any {
        ""
    }
    
    func activityViewController(
        _: UIActivityViewController,
        itemForActivityType _: UIActivity.ActivityType?
    ) -> Any? {
        nil
    }
    
    func activityViewControllerLinkMetadata(
        _: UIActivityViewController
    ) -> LPLinkMetadata? {
        guard let image = imageView.image else { return nil }
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        return metadata
    }
}
