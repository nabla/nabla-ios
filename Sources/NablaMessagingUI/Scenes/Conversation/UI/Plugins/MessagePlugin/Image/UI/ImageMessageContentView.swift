import Foundation
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
        imageView.url = viewModel.url

        nabla.constraintToSize(idealSize(contentSize: viewModel.originalImageSize))
    }
    
    func configure(sender: ConversationMessageSender) {}
    
    func prepareForReuse() {
        imageView.url = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: UIURLImageView = {
        let imageView = UIURLImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
