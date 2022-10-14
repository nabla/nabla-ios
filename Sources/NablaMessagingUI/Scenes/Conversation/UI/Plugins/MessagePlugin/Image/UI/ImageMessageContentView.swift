import Foundation
import NablaCore
import UIKit

private enum Constants {
    static let defaultSize = CGSize(width: 172, height: 172)
    static let maxWidth: CGFloat = 288
    static let maxHeight: CGFloat = 288
}

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
        imageView.imageSource = viewModel.imageSource

        nabla.constraintToSize(idealSize(contentSize: viewModel.originalImageSize))
    }
    
    func configure(sender _: ConversationMessageSender) {}
    
    func prepareForReuse() {
        imageView.imageSource = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: NablaViews.ImageView = {
        let imageView = NablaViews.ImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
