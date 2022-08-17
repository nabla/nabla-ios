import AVFoundation
import AVKit
import Foundation
import UIKit

private enum Constants {
    static let defaultSize = CGSize(width: 172, height: 172)
    static let maxWidth: CGFloat = 288
    static let maxHeight: CGFloat = 288
}

final class VideoMessageContentView: UIView, MessageContentView {
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
    
    func configure(with viewModel: VideoMessageContentViewModel) {
        playerView.player = AVPlayer(url: viewModel.url)

        nabla.constraintToSize(idealSize(contentSize: viewModel.originalVideoSize))
    }
    
    func configure(sender: ConversationMessageSender) {}
    
    func prepareForReuse() {
        playerView.player = nil
    }
    
    // MARK: - Private

    private lazy var playerView: AVPlayerViewController = makePlayerView()

    private func setUp() {
        addSubview(playerView.view)
        playerView.view.nabla.pinToSuperView()
    }
    
    private func makePlayerView() -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
        playerViewController.videoGravity = .resizeAspectFill
        return playerViewController
    }
}

extension MessageContentView {
    func idealSize(contentSize: CGSize?) -> CGSize {
        guard let size = contentSize else { return Constants.defaultSize }
        let ratio = size.width / size.height
        if ratio > 1 {
            let width = min(Constants.maxWidth, size.width)
            return CGSize(
                width: width,
                height: min(Constants.maxHeight, size.height) / ratio
            )
        } else {
            let height = min(Constants.maxHeight, size.height)
            return CGSize(
                width: min(Constants.maxWidth, size.width) * ratio,
                height: height
            )
        }
    }
}
