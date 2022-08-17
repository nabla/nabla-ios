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
            button.setTitle(L10n.videoCallActionRequestButtonDefault, for: .normal)
            button.isEnabled = true
        case .opened:
            button.setTitle(L10n.videoCallActionRequestButtonInProgress, for: .normal)
            button.isEnabled = true
        case .closed:
            button.setTitle(L10n.videoCallActionRequestButtonClosed, for: .normal)
            button.isEnabled = false
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
        view.textColor = .darkText // TODO: Theming
        view.font = .systemFont(ofSize: 16, weight: .medium) // TODO: Theming
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.setTitleColor(.darkText, for: .normal) // TODO: Theming
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular) // TODO: Theming
        view.nabla.constraintHeight(44)
        view.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return view
    }()
    
    private func setUpSubviews() {
        let hstack = UIStackView(arrangedSubviews: [imageView, titleLabel])
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.alignment = .center
        hstack.spacing = 10
        
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
