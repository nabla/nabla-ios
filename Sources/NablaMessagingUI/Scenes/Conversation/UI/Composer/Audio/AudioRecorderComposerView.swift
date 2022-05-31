import Foundation
import NablaMessagingCore
import UIKit

class AudioRecorderComposerView: UIView, AudioRecorderComposerViewContract {
    var presenter: AudioRecorderComposerPresenter?

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }

    // MARK: - AudioRecorderComposerViewContract

    func configure(with viewModel: AudioRecorderComposerViewModel) {
        durationLabel.text = viewModel.duration
    }

    // MARK: - Public

    func startRecording() {
        presenter?.userDidRequestStartRecording()
    }

    func stopRecording() {
        presenter?.userDidRequestStopRecording()
    }

    func cancelRecording() {
        presenter?.userDidRequestCancelRecording()
    }

    // MARK: - Private

    private lazy var durationLabel: UILabel = makeDurationLabel()
    private lazy var recordingIndocator: UIView = makeRecordingIndicator()

    private func setUp() {
        let recordingIndocatorContainer = UIView()
        recordingIndocatorContainer.addSubview(recordingIndocator)
        recordingIndocator.centerInSuperView(along: .vertical)
        recordingIndocator.pinToSuperView(edges: .horizontal)

        let stackView = UIStackView(arrangedSubviews: [recordingIndocatorContainer, durationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill

        addSubview(stackView)
        stackView.centerInSuperView()

        backgroundColor = NablaTheme.AudioRecorderComposerView.backgroundColor
        clipsToBounds = true
    }

    private func makeDurationLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.AudioRecorderComposerView.durationTextColor
        return label
    }

    private func makeRecordingIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.AudioRecorderComposerView.recordIndicatorColor
        view.constraintToSize(.init(width: 8, height: 8))
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }
}
