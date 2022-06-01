import Foundation
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
        playPauseButton.pinToSuperView(edges: [.top, .bottom, .leading], insets: .only(top: 8, leading: 10, bottom: 8))
        addSubview(durationLabel)
        durationLabel.pinToSuperView(edges: .trailing, insets: .only(trailing: 10))
        durationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 44).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: AudioMessageContentViewModel, sender: ConversationMessageSender) {
        durationLabel.text = viewModel.duration

        let imageName = viewModel.isPlayling ? Constants.pauseImageName : Constants.playImageName
        playPauseButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
        
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
        button.constraintToSize(Constants.buttonSize)
        button.setBackgroundImage(UIImage(systemName: Constants.playImageName), for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }

    private func makeDurationLabel() -> UILabel {
        let label = UILabel().prepareForAutoLayout()
        label.font = NablaTheme.Conversation.audioMessageDurationLabelFont
        label.constraintWidth(44)
        return label
    }

    @objc private func playPauseButtonTapped() {
        delegate?.audioMessageContentViewDidTapPlayPauseButton(self)
    }
}
