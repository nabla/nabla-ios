import UIKit

class ConversationMessagePreviewView: UIView {
    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: - Public

    func configure(with viewModel: ConversationMessagePreviewViewModel,
                   sender: ConversationMessageSender) {
        iconImageView.image = viewModel.icon
        authorLabel.text = viewModel.author
        previewLabel.text = viewModel.preview
        previewImageView.url = viewModel.previewImageURL

        iconImageViewContainer.isHidden = viewModel.icon == nil
        previewImageView.isHidden = viewModel.previewImageURL == nil

        switch sender {
        case .me:
            separatorView.backgroundColor = NablaTheme.Conversation.replyToPatientSeparatorColor
            iconImageView.tintColor = NablaTheme.Conversation.replyToPatientPreviewColor
            authorLabel.textColor = NablaTheme.Conversation.replyToPatientPreviewColor
            previewLabel.textColor = NablaTheme.Conversation.replyToPatientPreviewColor
        case .them:
            separatorView.backgroundColor = NablaTheme.Conversation.replyToProviderSeparatorColor
            iconImageView.tintColor = NablaTheme.Conversation.replyToProviderPreviewColor
            authorLabel.textColor = NablaTheme.Conversation.replyToProviderPreviewColor
            previewLabel.textColor = NablaTheme.Conversation.replyToProviderPreviewColor
        }
    }

    // MARK: - Private

    private lazy var separatorView: UIView = makeSeparatorView()
    private lazy var iconImageView: UIImageView = makeIconImageView()
    private lazy var iconImageViewContainer: UIView = makeIconImageViewContainer()
    private lazy var authorLabel: UILabel = makeAuthorLabel()
    private lazy var previewLabel: UILabel = makePreviewLabel()
    private lazy var previewImageView: UIURLImageView = makePreviewImageView()

    private func setUp() {
        let hStack = UIStackView(arrangedSubviews: [iconImageViewContainer, previewLabel])
        hStack.axis = .horizontal
        hStack.spacing = 4

        let vStack = UIStackView(arrangedSubviews: [authorLabel, hStack])
        vStack.axis = .vertical
        vStack.spacing = 4

        let stackView = UIStackView(arrangedSubviews: [separatorView, vStack, previewImageView])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.setCustomSpacing(26, after: vStack)

        addSubview(stackView)
        stackView.pinToSuperView(insets: .init(top: 10, leading: 10, bottom: 0, trailing: 10))

        previewImageView.isHidden = true
    }

    private func makeSeparatorView() -> UIView {
        let view = UIView()
        view.constraintWidth(1)
        return view
    }

    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.constraintToSize(.init(width: 10, height: 10))
        return imageView
    }

    private func makeIconImageViewContainer() -> UIView {
        let view = UIView()
        view.addSubview(iconImageView)
        iconImageView.centerInSuperView(along: .vertical)
        iconImageView.pinToSuperView(edges: .horizontal)
        return view
    }

    private func makeAuthorLabel() -> UILabel {
        let label = UILabel()
        label.font = NablaTheme.Conversation.replyToAuthorFont
        return label
    }

    private func makePreviewLabel() -> UILabel {
        let label = UILabel()
        label.font = NablaTheme.Conversation.replyToPreviewFont
        return label
    }

    private func makePreviewImageView() -> UIURLImageView {
        let imageView = UIURLImageView()
        imageView.constraintToSize(.init(width: 32, height: 32))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.alpha = 0.8
        return imageView
    }
}
