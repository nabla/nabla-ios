import Foundation
import NablaCore
import UIKit

final class VideoCallActionRequestContentView: UIView, MessageContentView {
    // MARK: - Internal
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setUpSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(presenter: VideoCallActionRequestPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: VideoCallActionRequestContentViewModel) {
        switch viewModel.state {
        case .waiting:
            subTitleLabel.isHidden = true
            hstack?.alignment = .center
            button.setTitle(L10n.videoCallActionRequestButtonDefault, for: .normal)
            button.isHidden = false
        case .opened:
            subTitleLabel.isHidden = true
            hstack?.alignment = .center
            button.setTitle(L10n.videoCallActionRequestButtonInProgress, for: .normal)
            button.isHidden = false
        case .closed:
            subTitleLabel.isHidden = false
            hstack?.alignment = .top
            button.setTitle(L10n.videoCallActionRequestButtonClosed, for: .normal)
            button.isHidden = true
        }
    }
    
    func configure(sender _: ConversationMessageSender) {}
    
    func prepareForReuse() {}

    // MARK: - Private
    
    private var presenter: VideoCallActionRequestPresenter?
    
    // MARK: Subviews
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = CoreAssets.Assets.videoCallActionRequestIcon.image
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.videoCallActionRequestTitle
        view.textColor = NablaTheme.Conversation.textMessageProviderTextColor
        view.font = NablaTheme.bodyMedium
        view.numberOfLines = 1
        view.nabla.constraintHeight(24)
        return view
    }()

    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.videoCallActionRequestButtonClosed
        view.textColor = NablaTheme.Conversation.textMessageProviderTextColor
        view.font = NablaTheme.body
        view.nabla.constraintHeight(24)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = NablaTheme.Conversation.videoCallActionRequestActionButtonBackgroundColor
        view.layer.cornerRadius = NablaTheme.Conversation.videoCallActionRequestCornerRadius
        view.layer.masksToBounds = true
        view.setTitleColor(NablaTheme.primaryTextColor, for: .normal)
        view.titleLabel?.font = NablaTheme.body
        view.nabla.constraintHeight(44)
        view.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return view
    }()

    private var hstack: UIStackView?
    
    private func setUpSubviews() {
        let titlesStack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        titlesStack.axis = .vertical
        titlesStack.distribution = .fill
        titlesStack.spacing = 0

        let hstack = UIStackView(arrangedSubviews: [imageView, titlesStack])
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.alignment = .center
        hstack.spacing = 10
        self.hstack = hstack
        
        let vstack = UIStackView(arrangedSubviews: [hstack, button])
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.alignment = .fill
        vstack.spacing = 16
        
        addSubview(vstack)
        vstack.nabla.pinToSuperView(insets: .nabla.all(10))
    }
    
    @objc private func buttonHandler() {
        presenter?.userDidTapJoinRoomButton()
    }
}
