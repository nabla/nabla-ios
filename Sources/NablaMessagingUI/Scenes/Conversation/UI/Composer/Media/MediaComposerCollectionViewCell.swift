import AVKit
import Foundation
import NablaMessagingCore
import UIKit

protocol MediaComposerCollectionViewCellDelegate: AnyObject {
    func mediaComposerCollectionViewCellDidTapDeleteButton(_ cell: MediaComposerCollectionViewCell)
}

class MediaComposerCollectionViewCell: UICollectionViewCell, Reusable {
    weak var delegate: MediaComposerCollectionViewCellDelegate?
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    func configure(with viewModel: MediaComposerItemViewModel) {
        switch viewModel.type {
        case .image:
            imageView.url = viewModel.url
        case .pdf:
            imageView.image = NablaTheme.Conversation.mediaComposerDocumentIcon
        }
    }
    
    // MARK: Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.url = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: UIURLImageView = makeImageView()
    private lazy var deleteButton: UIButton = makeDeleteButton()
    private lazy var deleteButtonContainerView: UIView = makeDeleteButtonContainerView()
    
    private func makeImageView() -> UIURLImageView {
        let view = UIURLImageView()
        view.tintColor = NablaTheme.Conversation.mediaComposerDocumentTintColor
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }
    
    private func makeDeleteButton() -> UIButton {
        let button = UIButton()
        button.setImage(NablaTheme.Conversation.mediaComposerDeleteButtonIcon, for: .normal)
        button.tintColor = NablaTheme.Conversation.mediaCompsoerDeleteButtonTintColor
        button.addTarget(self, action: #selector(deleteButtonSelected), for: .touchUpInside)
        return button
    }
    
    private func makeDeleteButtonContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.Conversation.mediaComposerDeleteButtonBackgroundColor
        view.addSubview(deleteButton)
        deleteButton.pinToSuperView()
        view.constraintToSize(.init(width: 15, height: 15))
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }
    
    private func setUp() {
        guard contentView.subviews.isEmpty else { return }
        contentView.isUserInteractionEnabled = false
        contentView.backgroundColor = NablaTheme.Conversation.mediaComposerBackgroundColor
        
        addSubview(imageView)
        imageView.pinToSuperView()
        
        addSubview(deleteButtonContainerView)
        deleteButtonContainerView.pinToSuperView(edges: [.top, .trailing], insets: .init(horizontal: 5, vertical: 5))
        
        layer.cornerRadius = 12.0
        clipsToBounds = true
    }
    
    @objc private func deleteButtonSelected() {
        delegate?.mediaComposerCollectionViewCellDidTapDeleteButton(self)
    }
}
