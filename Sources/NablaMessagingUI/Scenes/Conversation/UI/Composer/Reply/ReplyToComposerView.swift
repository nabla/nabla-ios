import NablaMessagingCore
import UIKit

class ReplyToComposerView: UIView, ReplyToComposerViewContract {
    var presenter: ReplyToComposerPresenter?

    // MARK: Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: - ReplyToComposerViewContract

    func configure(with viewModel: ReplyToComposerViewModel) {
        authorLabel.text = viewModel.sender
        previewLabel.text = viewModel.preview
        previewImageView.url = viewModel.imagePreviewURL

        previewImageView.isHidden = viewModel.imagePreviewURL == nil
    }

    // MARK: - Public

    var message: ConversationViewMessageItem? {
        didSet {
            presenter?.didUpdate(message: message)
        }
    }

    // MARK: - Private

    private lazy var border: UIView = makeBorder()
    private lazy var authorLabel: UILabel = makeAuthorLabel()
    private lazy var previewLabel: UILabel = makePreviewLabel()
    private lazy var previewImageView: UIURLImageView = makePreviewImageView()
    private lazy var closeButton: UIButton = makeCloseButton()

    private func setUp() {
        let vStack = UIStackView(arrangedSubviews: [authorLabel, previewLabel])
        vStack.axis = .vertical
        vStack.spacing = 4

        let hStack = UIStackView(arrangedSubviews: [vStack, previewImageView])
        hStack.axis = .horizontal
        hStack.spacing = 8

        addSubview(border)
        addSubview(hStack)
        addSubview(closeButton)

        border.nabla.pinToSuperView(edges: [.leading, .trailing, .top])
        hStack.nabla.pinToSuperView(edges: [.leading, .top, .bottom], insets: .init(top: 12, leading: 12, bottom: 0, trailing: 12))
        hStack.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor).isActive = true

        closeButton.nabla.pinToSuperView(edges: [.trailing, .bottom], insets: .nabla.make(horizontal: 12, vertical: 8))
    }

    private func makeBorder() -> UIView {
        let view = UIView()
        view.nabla.constraintHeight(1)
        view.backgroundColor = NablaTheme.accessoryColor
        return view
    }

    private func makeAuthorLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.Conversation.composerReplyToAuthorColor
        label.font = NablaTheme.Conversation.composerReplyToAuthorFont
        return label
    }

    private func makePreviewLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.Conversation.composerReplyToPreviewColor
        label.font = NablaTheme.Conversation.composerReplyToPreviewFont
        return label
    }

    private func makePreviewImageView() -> UIURLImageView {
        let imageView = UIURLImageView()
        imageView.nabla.constraintToSize(.init(width: 40, height: 40))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    private func makeCloseButton() -> UIButton {
        let button = UIButton()
        button.setImage(NablaTheme.Conversation.composerReplyToCloseButtonImage, for: .normal)
        button.tintColor = NablaTheme.Conversation.composerReplyToCloseButtonColor
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.nabla.constraintToSize(.init(width: 24, height: 24))
        button.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        return button
    }

    @objc private func closeButtonTapped() {
        presenter?.didTapCloseButton()
    }
}
