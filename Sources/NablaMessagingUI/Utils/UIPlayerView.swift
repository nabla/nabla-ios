import AVFoundation
import NablaCore
import NablaMessagingCore
import UIKit

class UIPlayerView: UIView {
    // MARK: - Public

    var playerLayer: AVPlayerLayer {
        // swiftlint:disable:next force_cast
        layer as! AVPlayerLayer
    }

    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    func setMediaSource(mediaSource: MediaSource) throws {
        player.replaceCurrentItem(with: AVPlayerItem(asset: try DataAVAsset(source: mediaSource)))
    }

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: Private

    private lazy var player = AVPlayer()

    private func setUp() {
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
    }
}
