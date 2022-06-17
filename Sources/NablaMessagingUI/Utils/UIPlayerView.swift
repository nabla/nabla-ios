import AVFoundation
import UIKit

class UIPlayerView: UIView {
    // MARK: - Public

    var url: URL? {
        didSet {
            guard let url = url else {
                player.replaceCurrentItem(with: nil)
                return
            }

            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
    }

    var playerLayer: AVPlayerLayer {
        // swiftlint:disable:next force_cast
        layer as! AVPlayerLayer
    }

    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: Private

    private lazy var player = makePlayer()

    private func setUp() {
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
    }

    private func makePlayer() -> AVPlayer {
        let player = AVPlayer()
        return player
    }
}
