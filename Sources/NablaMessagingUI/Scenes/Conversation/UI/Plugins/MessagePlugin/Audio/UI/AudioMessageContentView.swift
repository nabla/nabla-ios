import Foundation
import NablaCore
import UIKit

private enum Constants {
    static let playImageName = "play.circle.fill"
    static let pauseImageName = "pause.circle.fill"
    static let buttonSize = CGSize(width: 28, height: 28)
}

protocol AudioMessageContentViewDelegate: AnyObject {
    func audioMessageContentViewDidTapPlayPauseButton(_ view: AudioMessageContentView)
}

final class AudioMessageContentView: UIView, MessageContentView {
    weak var delegate: AudioMessageContentViewDelegate?

    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        addSubview(playPauseButton)
        playPauseButton.nabla.pinToSuperView(edges: [.top, .bottom, .leading], insets: .nabla.only(top: 8, leading: 10, bottom: 8))
        addSubview(durationLabel)
        durationLabel.nabla.pinToSuperView(edges: .trailing, insets: .nabla.only(trailing: 10))
        durationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 44).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: AudioMessageContentViewModel) {
        durationLabel.text = viewModel.duration

        let imageName = viewModel.isPlaying ? Constants.pauseImageName : Constants.playImageName
        playPauseButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func configure(sender: ConversationMessageSender) {
        switch sender {
        case .me:
            durationLabel.textColor = NablaTheme.Conversation.audioMessagePatientTitleColor
            playPauseButton.tintColor = NablaTheme.Conversation.audioMessagePatientTitleColor
        case .provider:
            durationLabel.textColor = NablaTheme.Conversation.audioMessageProviderTitleColor
            playPauseButton.tintColor = NablaTheme.Conversation.audioMessageProviderTitleColor
        case .other:
            durationLabel.textColor = NablaTheme.Conversation.audioMessageOtherTitleColor
            playPauseButton.tintColor = NablaTheme.Conversation.audioMessageOtherTitleColor
        }
    }
    
    func prepareForReuse() {}
    
    // MARK: - Private
    
    private lazy var playPauseButton: UIButton = makePlayPauseButton()
    private lazy var durationLabel: UILabel = makeDurationLabel()

    private func makePlayPauseButton() -> UIButton {
        let button = UIButton()
        button.nabla.constraintToSize(Constants.buttonSize)
        button.setBackgroundImage(UIImage(systemName: Constants.playImageName), for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }

    private func makeDurationLabel() -> UILabel {
        let label = UILabel()
        label.font = NablaTheme.Conversation.audioMessageDurationLabelFont
        label.nabla.constraintWidth(44)
        return label
    }

    @objc private func playPauseButtonTapped() {
        delegate?.audioMessageContentViewDidTapPlayPauseButton(self)
    }
}
