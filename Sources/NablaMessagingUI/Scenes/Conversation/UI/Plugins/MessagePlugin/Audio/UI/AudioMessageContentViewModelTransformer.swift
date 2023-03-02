import Foundation

class AudioMessageContentViewModelTransformer {
    // MARK: - Public

    func transform(item _: AudioMessageViewItem) -> AudioMessageContentViewModel {
        AudioMessageContentViewModel(
            isPlaying: isPlaying,
            duration: durationMapper.map(durationInSeconds: currentTimeSeconds)
        )
    }

    func update(isPlaying: Bool, currentTimeSeconds: Int) {
        self.isPlaying = isPlaying
        self.currentTimeSeconds = currentTimeSeconds
    }

    // MARK: - Private

    private let durationMapper = DurationMapper()

    private var isPlaying = false
    private var currentTimeSeconds = 0
}
