import Foundation
import UIKit

private enum Constants {
    static let thumbnailSize: CGSize = .init(width: 24, height: 24)
    static let imageSize: CGSize = .init(width: 200, height: 124)
    static let bottomViewHeight: CGFloat = 48
    static let bottomViewPadding = NSDirectionalEdgeInsets(horizontal: 12, vertical: 0)
}

class DocumentMessageContentView: UIView, MessageContentView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: DocumentMessageContentViewModel, sender: ConversationMessageSender) {
        imageView.url = viewModel.url
        label.text = viewModel.filename
        
        switch sender {
        case .me:
            label.textColor = NablaTheme.Conversation.documentMessagePatientTitleColor
            iconImageView.tintColor = NablaTheme.Conversation.documentMessagePatientTitleColor
        case .them:
            label.textColor = NablaTheme.Conversation.documentMessageProviderTitleColor
            iconImageView.tintColor = NablaTheme.Conversation.documentMessageProviderTitleColor
        }
    }
    
    func prepareForReuse() {
        imageView.url = nil
        label.text = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: UIURLImageView = createImageView()
    private lazy var label: UILabel = createLabel()
    private lazy var iconImageView: UIImageView = createIconImageView()
    private lazy var bottomView: UIView = createBottomView()
    
    private func setUp() {
        let hstack = UIStackView(arrangedSubviews: [
            imageView,
            bottomView,
        ])
        hstack.axis = .vertical
        hstack.alignment = .fill
        hstack.distribution = .fill
        
        addSubview(hstack)
        hstack.pinToSuperView()
    }
    
    private func createImageView() -> UIURLImageView {
        let imageView = UIURLImageView(frame: .zero)
        imageView.constraintToSize(Constants.imageSize)
        imageView.image = CoreAssets.Assets.documentPlaceholder.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = NablaTheme.Conversation.documentMessageTitleFont
        return label
    }
    
    private func createIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = NablaTheme.Conversation.documentMessageIcon
        imageView.contentMode = .scaleAspectFit
        imageView.constraintToSize(Constants.thumbnailSize)
        return imageView
    }
    
    private func createBottomView() -> UIView {
        let vStack = UIStackView(arrangedSubviews: [iconImageView, label])
        vStack.axis = .horizontal
        vStack.spacing = 4
        vStack.alignment = .center
        vStack.constraintHeight(Constants.bottomViewHeight)
        
        let view = UIView()
        view.addSubview(vStack)
        
        vStack.pinToSuperView(insets: Constants.bottomViewPadding)
        
        return view
    }
}
