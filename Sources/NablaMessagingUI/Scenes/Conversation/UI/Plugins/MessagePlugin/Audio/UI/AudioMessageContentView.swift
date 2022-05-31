import Foundation
import UIKit

private enum Constants {
    static let playImageName = "play.circle.fill"
    static let pauseImageName = "pause.circle.fill"
}

protocol AudioMessageContentViewDelegate: AnyObject {
    func audioMessageContentViewDidTapPlayPauseButton(_ view: AudioMessageContentView)
}

final class AudioMessageContentView: UIView, MessageContentView {
    weak var delegate: AudioMessageContentViewDelegate?

    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        let stackView = UIStackView(arrangedSubviews: [playPauseButton, durationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 48
        addSubview(stackView)
        stackView.pinToSuperView(insets: .init(horizontal: 16, vertical: 8))
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: AudioMessageContentViewModel, sender: ConversationMessageSender) {
        durationLabel.text = viewModel.duration

        let imageName = viewModel.isPlayling ? Constants.pauseImageName : Constants.playImageName
        let image = UIImage(systemName: imageName)
        playPauseButton.setImage(image, for: .normal)

        switch sender {
        case .me:
            durationLabel.textColor = NablaTheme.Conversation.audioMessagePatientTitleColor
            playPauseButton.tintColor = NablaTheme.Conversation.audioMessagePatientTitleColor
        case .them:
            durationLabel.textColor = NablaTheme.Conversation.audioMessageProviderTitleColor
            playPauseButton.tintColor = NablaTheme.Conversation.audioMessageProviderTitleColor
        }
    }
    
    func prepareForReuse() {}
    
    // MARK: - Private
    
    private lazy var playPauseButton: UIButton = makePlayPauseButton()
    private lazy var durationLabel: UILabel = makeDurationLabel()

    private func makePlayPauseButton() -> UIButton {
        let button = UIButton().prepareForAutoLayout()
        button.setImage(UIImage(systemName: Constants.playImageName), for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }

    private func makeDurationLabel() -> UILabel {
        let label = UILabel().prepareForAutoLayout()
        label.font = NablaTheme.Conversation.audioMessageDurationLabelFont
        label.constraintWidth(45)
        return label
    }

    @objc private func playPauseButtonTapped() {
        delegate?.audioMessageContentViewDidTapPlayPauseButton(self)
    }
}
