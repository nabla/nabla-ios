import Foundation
import NablaCore
import UIKit

private enum Constants {
    static let thumbnailSize: CGSize = .init(width: 14, height: 14)
    static let imageSize: CGSize = .init(width: 200, height: 124)
    static let bottomViewHeight: CGFloat = 48
    static let bottomViewPadding: NSDirectionalEdgeInsets = .nabla.make(horizontal: 12, vertical: 0)
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
    
    func configure(with viewModel: DocumentMessageContentViewModel) {
        if let thumbnail = viewModel.thumbnail {
            imageView.source = thumbnail
        } else {
            imageView.image = CoreAssets.Assets.documentPlaceholder.image
        }
        label.text = viewModel.filename
    }
    
    func configure(sender: ConversationMessageSender) {
        switch sender {
        case .me:
            label.textColor = NablaTheme.Conversation.documentMessagePatientTitleColor
            iconImageView.tintColor = NablaTheme.Conversation.documentMessagePatientTitleColor
        case .provider:
            label.textColor = NablaTheme.Conversation.documentMessageProviderTitleColor
            iconImageView.tintColor = NablaTheme.Conversation.documentMessageProviderTitleColor
        case .other:
            label.textColor = NablaTheme.Conversation.documentMessageOtherTitleColor
            iconImageView.tintColor = NablaTheme.Conversation.documentMessageOtherTitleColor
        }
    }
    
    func prepareForReuse() {
        imageView.source = nil
        label.text = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: NablaViews.ImageView = createImageView()
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
        hstack.nabla.pinToSuperView()
    }
    
    private func createImageView() -> NablaViews.ImageView {
        let imageView = NablaViews.ImageView(frame: .zero)
        imageView.nabla.constraintToSize(Constants.imageSize)
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
        imageView.nabla.constraintToSize(Constants.thumbnailSize)
        return imageView
    }
    
    private func createBottomView() -> UIView {
        let vStack = UIStackView(arrangedSubviews: [iconImageView, label])
        vStack.axis = .horizontal
        vStack.spacing = 4
        vStack.alignment = .center
        vStack.nabla.constraintHeight(Constants.bottomViewHeight)
        
        let view = UIView()
        view.addSubview(vStack)
        
        vStack.nabla.pinToSuperView(insets: Constants.bottomViewPadding)
        
        return view
    }
}
