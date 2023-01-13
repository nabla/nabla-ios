import Foundation
import NablaCore
import NablaMessagingCore

class AudioRecorderComposerPresenterImpl: AudioRecorderComposerPresenter {
    struct Dependencies {
        let logger: Logger
    }

    weak var delegate: AudioRecorderComposerPresenterDelegate?

    // MARK: - Initializer

    init(
        viewContract: AudioRecorderComposerViewContract,
        dependencies: Dependencies
    ) {
        self.viewContract = viewContract
        logger = dependencies.logger
    }

    // MARK: - Presenter

    func start() {
        updateUI()
    }

    // MARK: - AudioRecorderComposerPresenter

    func userDidRequestStartRecording() {
        recorder.requestPermission { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(allowed):
                if allowed {
                    self.recorder.startRecording()
                    self.delegate?.audioRecorderComposerPresenterDidStartRecording(self)
                } else {
                    self.logger.info(message: "User denied microphone access")
                    self.delegate?.audioRecorderComposerPresenterCanNotStartRecording(self)
                }
            case let .failure(error):
                self.logger.warning(message: "Unable to start recording audio message", error: error)
                self.delegate?.audioRecorderComposerPresenterCanNotStartRecording(self)
            }
        }
    }

    func userDidRequestStopRecording() {
        recorder.stopRecording { [weak self] file in
            guard let self = self else { return }
            self.delegate?.audioRecorderComposerPresenter(self, didStopRecordingWithFile: file)
        }
    }

    func userDidRequestCancelRecording() {
        recorder.stopRecording { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.audioRecorderComposerPresenterDidCancelRecording(self)
        }
    }

    // MARK: - Public

    // MARK: - Private

    private let logger: Logger

    private weak var viewContract: AudioRecorderComposerViewContract?

    private var currentDuration = 0 {
        didSet {
            updateUI()
        }
    }

    private lazy var recorder: AudioRecorder = {
        let recorder = AudioRecorder(dependencies: .init(logger: logger))
        recorder.delegate = self
        return recorder
    }()

    private func updateUI() {
        let viewModel = Self.transform(duration: currentDuration)
        viewContract?.configure(with: viewModel)
    }

    private static func transform(duration: Int) -> AudioRecorderComposerViewModel {
        let durationMapper = DurationMapper()
        return AudioRecorderComposerViewModel(duration: durationMapper.map(durationInSeconds: duration / 1000))
    }
}

extension AudioRecorderComposerPresenterImpl: AudioRecorderDelegate {
    // MARK: - AudioRecorderDelegate

    func audioRecorder(_: AudioRecorder, didUpdateCurrentRecordingTime time: TimeInterval) {
        currentDuration = Int(time)
    }
}
