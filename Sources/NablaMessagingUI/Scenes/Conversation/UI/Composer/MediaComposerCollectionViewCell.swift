import AVKit
import Foundation
import NablaMessagingCore
import UIKit

protocol MediaComposerCollectionViewCellDelegate: AnyObject {
    func mediaComposerCollectionVIewCell(_ cell: MediaComposerCollectionViewCell, didTapDeleteButtonFor media: Media)
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
    
    func configure(with media: Media) {
        // TODO: Thibault Tourailles - Don't use media directly
        self.media = media
        switch media.type {
        case .image:
            imageView.url = media.fileUrl
            imageView.isHidden = false
            previewView.view.isHidden = true
        case .video:
            previewView.player = AVPlayer(url: media.fileUrl)
            imageView.isHidden = true
            previewView.view.isHidden = false
        case .pdf:
            imageView.image = NablaTheme.MediaComposerCollectionViewCell.documentIcon
            imageView.isHidden = false
            previewView.view.isHidden = true
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
        previewView.player = nil
    }
    
    // MARK: - Private
    
    private lazy var imageView: UIURLImageView = makeImageView()
    private lazy var previewView: AVPlayerViewController = makePreviewView()
    private lazy var deleteButton: UIButton = makeDeleteButton()
    private lazy var deleteButtonContainerView: UIView = makeDeleteButtonContainerView()
    
    private var media: Media?
    
    private func makeImageView() -> UIURLImageView {
        let view = UIURLImageView()
        view.tintColor = NablaTheme.MediaComposerCollectionViewCell.documentTintColor
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }
    
    private func makePreviewView() -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.videoGravity = .resizeAspectFill
        playerViewController.showsPlaybackControls = false
        return playerViewController
    }
    
    private func makeDeleteButton() -> UIButton {
        let button = UIButton()
        button.setImage(NablaTheme.MediaComposerCollectionViewCell.deleteButtonIcon, for: .normal)
        button.tintColor = NablaTheme.MediaComposerCollectionViewCell.deleteButtonTintColor
        button.addTarget(self, action: #selector(deleteButtonSelected), for: .touchUpInside)
        return button
    }
    
    private func makeDeleteButtonContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.MediaComposerCollectionViewCell.deleteButtonBackgroundColor
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
        contentView.backgroundColor = NablaTheme.MediaComposerCollectionViewCell.backgroundColor
        
        addSubview(imageView)
        imageView.pinToSuperView()
        
        addSubview(previewView.view)
        previewView.view.pinToSuperView()
        
        addSubview(deleteButtonContainerView)
        deleteButtonContainerView.pinToSuperView(edges: [.top, .trailing], insets: .init(horizontal: 5, vertical: 5))
        
        layer.cornerRadius = 12.0
        clipsToBounds = true
        
        parentViewController?.addChild(previewView)
    }
    
    @objc private func deleteButtonSelected() {
        guard let media = media else { return }
        delegate?.mediaComposerCollectionVIewCell(self, didTapDeleteButtonFor: media)
    }
}
