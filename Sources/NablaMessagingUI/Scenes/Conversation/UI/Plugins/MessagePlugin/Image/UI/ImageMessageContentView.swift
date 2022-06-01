import Foundation
import UIKit

final class ImageMessageContentView: UIView, MessageContentView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        imageView.pinToSuperView()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: ImageMessageContentViewModel, sender _: ConversationMessageSender) {
        imageView.url = viewModel.url
    }
    
    func prepareForReuse() {
        imageView.url = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: UIURLImageView = {
        let imageView = UIURLImageView().prepareForAutoLayout()
        imageView.constraintToSize(.init(width: 172, height: 172))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
