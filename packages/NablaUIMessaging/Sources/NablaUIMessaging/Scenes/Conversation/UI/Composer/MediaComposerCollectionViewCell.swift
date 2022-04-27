import AVKit
import Foundation
import NablaCore
import UIKit

protocol MediaComposerCollectionViewCellDelegate: AnyObject {
    func mediaComposerCollectionVIewCell(_ cell: MediaComposerCollectionViewCell, didTapDeleteButtonFor media: Media)
}

class MediaComposerCollectionViewCell: UICollectionViewCell, Reusable {
    weak var delegate: MediaComposerCollectionViewCellDelegate?
    
    private lazy var imageView: UIURLImageView = self.makeImageView()
    private lazy var previewView: AVPlayerViewController = self.makePreviewView()
    private lazy var deleteButton: UIButton = self.makeDeleteButton()
    
    private var media: Media?
    
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
        }
    }
    
    // MARK: Lifecycle
    
    override func didMoveToSuperview() {
        setUp()
    }
    
    // MARK: - Private
    
    private func makeImageView() -> UIURLImageView {
        let view = UIURLImageView()
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 12.0
        view.clipsToBounds = true
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
        button.setImage(CoreAssets.Assets.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }
    
    private func setUp() {
        guard subviews.isEmpty else { return }
        contentView.isUserInteractionEnabled = false
        
        addSubview(imageView)
        imageView.pinToSuperView()
        
        addSubview(previewView.view)
        previewView.view.pinToSuperView()
        
        addSubview(deleteButton)
        deleteButton.constraintToSize(.init(width: 10, height: 10))
        deleteButton.pinToSuperView(edges: [.top, .trailing], insets: .init(horizontal: 5, vertical: 5))
        deleteButton.addTarget(self, action: #selector(deleteButtonSelected), for: .touchUpInside)
        
        parentViewController?.addChild(previewView)
    }
    
    @objc private func deleteButtonSelected() {
        guard let media = media else { return }
        delegate?.mediaComposerCollectionVIewCell(self, didTapDeleteButtonFor: media)
    }
}
