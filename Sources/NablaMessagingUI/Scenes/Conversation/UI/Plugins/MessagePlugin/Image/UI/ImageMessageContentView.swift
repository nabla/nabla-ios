import Foundation
import NablaCore
import UIKit

final class ImageMessageContentView: UIView, MessageContentView {
    // MARK: - Init

    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        imageView.nabla.pinToSuperView()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: ImageMessageContentViewModel) {
        // Here
        imageView.source = viewModel.imageSource

        widthConstraint?.isActive = false
        heightConstraint?.isActive = false
        (widthConstraint, heightConstraint) = nabla.constraintToSize(idealSize(contentSize: viewModel.originalImageSize))
    }
    
    func configure(sender _: ConversationMessageSender) {}
    
    func prepareForReuse() {
        imageView.source = nil
    }
    
    // MARK: - Private

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var imageView: NablaViews.ImageView = {
        let imageView = NablaViews.ImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
