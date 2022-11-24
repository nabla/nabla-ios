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
        navigationController?.navigationBar.tintColor = NablaTheme.ImageDetail.iconsTintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        presenter?.start()
    }
    
    // MARK: - ImageDetailViewContract
    
    func configure(with viewModel: ImageDetailViewModel) {
        imageView.source = viewModel.image
        fileName = viewModel.fileName
        title = viewModel.fileName
    }
    
    // MARK: - Private
    
    private var fileName: String?
    
    private lazy var imageView: NablaViews.ImageView = makeImageView()

    private func setUp() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareAction)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(closeAction)
        )
        view.backgroundColor = NablaTheme.ImageDetail.backgroundColor
        view.addSubview(imageView)
        imageView.nabla.pin(to: view.safeAreaLayoutGuide)
    }
    
    private func makeImageView() -> NablaViews.ImageView {
        let imageView = NablaViews.ImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
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
    
    @objc private func closeAction() {
        dismiss(animated: true)
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
