import AVKit
import Foundation
import NablaCore
import NablaMessagingCore

protocol AudioPlayerDelegate: AnyObject {
    func audioPlayer(_ player: AudioPlayer, didUpdateCurrentPlayTime time: TimeInterval)
    func audioPlayer(_ player: AudioPlayer, didUpdatePlayingState isPlaying: Bool)
}

class AudioPlayer {
    struct Dependencies {
        let logger: Logger
    }

    weak var delegate: AudioPlayerDelegate?

    // MARK: - Initializer

    init(dependencies: Dependencies) {
        logger = dependencies.logger
    }

    // MARK: - Public

    func play(_ audioFile: AudioFile) {
        do {
            let avAsset = try DataAVAsset(source: audioFile.content)
            avAsset.loadValuesAsynchronously(forKeys: ["playable"]) { [weak self] in
                guard let self = self else { return }
                let playerItem = AVPlayerItem(asset: avAsset)
                self.setPlayerItem(playerItem)
                self.activateAudio()
                self.player.play()
                self.startCurrentTimePublication()
                self.isPlaying = true
            }
        } catch {
            logger.error(
                message: "Could not load audio asset from audio file",
                error: InternalError(underlyingError: error)
            )
        }
    }

    func pause() {
        player.pause()
        isPlaying = false

        stopCurrentTimePublication()
    }

    // MARK: Private

    private let logger: Logger
    private let player: AVPlayer = .init()

    private var currentItem: AVPlayerItem?
    private var progressTimer: Timer?
    private var observer: NSObjectProtocol?

    private var isPlaying = false {
        didSet {
            delegate?.audioPlayer(self, didUpdatePlayingState: isPlaying)
        }
    }

    private func activateAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        } catch {
            logger.error(message: "Cannot activate audio", error: error)
        }
    }

    private func setPlayerItem(_ playerItem: AVPlayerItem) {
        guard currentItem != playerItem else { return }
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer, name: .AVPlayerItemDidPlayToEndTime, object: currentItem)
        }

        player.replaceCurrentItem(with: playerItem)
        currentItem = playerItem

        observer = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.player.seek(to: .zero) { [weak self] _ in
                guard let self = self else { return }
                self.stopCurrentTimePublication()
                self.isPlaying = false
            }
        }
    }

    private func startCurrentTimePublication() {
        // ???: By default, this runs on a background loop and timer is not triggered
        DispatchQueue.main.async {
            self.progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                let time = self.player.currentTime()
                guard !CMTimeGetSeconds(time).isNaN else { return }

                self.delegate?.audioPlayer(self, didUpdateCurrentPlayTime: time.seconds)
            }
        }
    }

    private func stopCurrentTimePublication() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
}
