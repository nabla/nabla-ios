import NablaCore
import NablaMessagingCore
import UIKit

private enum Constants {
    static let avatarSize: CGFloat = 28
    static let bodyMaxWidth: CGFloat = 300
    static let spacing: CGFloat = 8
    static let messagePadding: UIEdgeInsets = .nabla.all(4)
    static let systemPadding: UIEdgeInsets = .nabla.make(horizontal: 0, vertical: 6)
    static let padding: UIEdgeInsets = .nabla.make(horizontal: 10, vertical: 1)
    static let authorFontSize: CGFloat = 14
    static let footerFontSize: CGFloat = 12
}

protocol ConversationMessagePresenter: Presenter {
    func userDidTapFooter()
    func userDidTapContent()
    func userDidSwipeSuccessfully()
    func userDidTapMessagePreview()
    func didFailContentConfig(underlyingError: Error)
}

final class ConversationMessageCell<ContentView: MessageContentView>: UICollectionViewCell, ConversationMessageCellContract, Reusable, UIGestureRecognizerDelegate {
    // MARK: Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }
    
    // MARK: - Public
    
    lazy var content: ContentView = .init()

    var allowSwipeGesture = true
    
    func configure(with viewModel: ConversationMessageViewModel<ContentView.ContentViewModel>) {
        configure(with: viewModel.sender)
        configure(with: viewModel.footer)
        configure(with: viewModel.replyTo, sender: viewModel.sender)
        do {
            try content.configure(with: viewModel.content)
        } catch {
            presenter?.didFailContentConfig(underlyingError: error)
        }
        content.configure(sender: viewModel.sender)
        menuElements = viewModel.menuElements
    }
    
    func configure(presenter: ConversationMessagePresenter) {
        self.presenter = presenter
        presenter.start()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        content.prepareForReuse()
        menuElements = []
    }
    
    // MARK: - Private
    
    private var presenter: ConversationMessagePresenter?
    private var menuElements: [UIMenuElement] = []
    
    private let leftSpacer = UISpacerView(axis: .horizontal)
    private let rightSpacer = UISpacerView(axis: .horizontal)
    private let topSpacer = UISpacerView(axis: .vertical, size: .fixed(value: 8), color: .clear)
    private let feedbackGenerator = UINotificationFeedbackGenerator()

    private var containerStackView: UIStackView?
    private lazy var authorLabel: UILabel = makeAuthorLabel()
    private lazy var header: UIView = makeHeader()
    private lazy var avatarContainerView: UIView = makeAvatarContainerView()
    private lazy var avatarView: NablaViews.AvatarView = makeAvatarView()
    private lazy var container: UIView = makeContainer()
    private lazy var messagePreviewView: ConversationMessagePreviewView = makeMessagePreviewView()
    private lazy var contentStackView: UIView = makeContentStackView()
    private lazy var replyView: UIView = makeReplyView()
    
    private lazy var footerLabel: UILabel = makeFooterLabel()
    
    private var footerTapAction: (() -> Void)?
    
    private lazy var contentTapGestureRecognizer: UITapGestureRecognizer = makeContentTapGestureRecognizer()
    private lazy var contentPanGestureRecognizer: UIPanGestureRecognizer = makeContentPanGestureRecognizer()
    private lazy var messagePreviewTapGestureRecognizer: UITapGestureRecognizer = makeMessagePreviewTapGestureRecognizer()

    private var canSendPanGestureToDelegate = true
    
    private func setUp() {
        guard contentView.subviews.isEmpty else { return }
        
        contentView.addSubview(contentStackView)
        contentStackView.nabla.pinToSuperView(insets: .nabla.horizontal(8), priority: .nabla.cellContentPriority)

        contentView.addSubview(replyView)
        replyView.nabla.constraintToCenterInSuperView(along: .vertical)

        replyView.trailingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 0).isActive = true

        addGestureRecognizer(contentPanGestureRecognizer)
    }
    
    private func configure(with sender: ConversationMessageSender) {
        switch sender {
        case let .me(isContiguous):
            footerLabel.textAlignment = .right
            container.backgroundColor = NablaTheme.Conversation.messagePatientBackgroundColor
            if isContiguous {
                setVisibleViews([leftSpacer])
            } else {
                setVisibleViews([topSpacer, leftSpacer])
            }
        case let .provider(providerViewModel):
            footerLabel.textAlignment = .left
            avatarView.avatar = providerViewModel.avatar
            authorLabel.text = providerViewModel.author
            container.backgroundColor = NablaTheme.Conversation.messageProviderBackgroundColor

            if providerViewModel.isContiguous {
                setVisibleViews([rightSpacer])
            } else {
                setVisibleViews([topSpacer, header, avatarView, rightSpacer])
            }
        case let .other(otherViewModel):
            footerLabel.textAlignment = .left
            avatarView.avatar = otherViewModel.avatar
            authorLabel.text = otherViewModel.author
            container.backgroundColor = NablaTheme.Conversation.messageOtherBackgroundColor

            if otherViewModel.isContiguous {
                setVisibleViews([rightSpacer])
            } else {
                setVisibleViews([topSpacer, header, avatarView, rightSpacer])
            }
        }
    }
    
    private func configure(with footer: ConversationMessageFooterViewModel?) {
        guard let footer = footer else {
            footerLabel.isHidden = true
            return
        }
        
        guard footerLabel.text != footer.text || footerLabel.textColor != footer.color else { return }
        
        footerLabel.isHidden = false
        
        footerLabel.text = footer.text
        footerLabel.textColor = footer.color
        footerTapAction = { [weak self] in
            self?.presenter?.userDidTapFooter()
        }
    }

    private func configure(with replyTo: ConversationMessagePreviewViewModel?, sender: ConversationMessageSender) {
        guard let replyTo = replyTo else {
            messagePreviewView.removeFromSuperview()
            return
        }

        if let contains = containerStackView?.arrangedSubviews.contains(messagePreviewView), !contains {
            containerStackView?.insertArrangedSubview(messagePreviewView, at: 0)
        }

        messagePreviewView.configure(with: replyTo, sender: sender)
    }
    
    private func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = NablaTheme.Conversation.messageCornerRadius
        view.clipsToBounds = true

        containerStackView = {
            let stackView = UIStackView(arrangedSubviews: [content])
            stackView.axis = .vertical
            view.addSubview(stackView)
            stackView.nabla.pinToSuperView()
            return stackView
        }()
        content.addGestureRecognizer(contentTapGestureRecognizer)
        content.nabla.constraintWidth(Constants.bodyMaxWidth, relation: .lessThanOrEqual)
        return view
    }
    
    private func makeAuthorLabel() -> UILabel {
        let label = UILabel()
        label.font = NablaTheme.Conversation.messageAuthorLabelFont
        label.numberOfLines = 1
        label.textColor = NablaTheme.Conversation.messageAuthorLabelColor
        return label
    }
    
    private func makeHeader() -> UIView {
        let hstack = UIStackView(arrangedSubviews: [
            UISpacerView(axis: .horizontal, size: .fixed(value: Constants.avatarSize + Constants.spacing)),
            authorLabel,
            UISpacerView(axis: .horizontal),
        ])
        hstack.axis = .horizontal
        hstack.alignment = .bottom
        hstack.distribution = .fill
        let vStack = UIStackView(arrangedSubviews: [hstack, UISpacerView(axis: .vertical, size: .fixed(value: 4))])
        vStack.axis = .vertical
        return vStack
    }

    private func makeMessagePreviewView() -> ConversationMessagePreviewView {
        let view = ConversationMessagePreviewView()
        view.addGestureRecognizer(messagePreviewTapGestureRecognizer)
        return view
    }
    
    private func makeFooterLabel() -> UILabel {
        let label = UILabel()
        label.font = NablaTheme.Conversation.messageFooterLabelFont
        label.numberOfLines = 0
        label.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(footerTapHandler))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        return label
    }
    
    private func makeAvatarView() -> NablaViews.AvatarView {
        let avatarView = NablaViews.AvatarView()
        return avatarView
    }
    
    private func makeAvatarContainerView() -> UIView {
        let view = UIView()
        view.nabla.constraintToSize(CGSize(width: Constants.avatarSize, height: Constants.avatarSize))
        view.addSubview(avatarView)
        avatarView.nabla.pinToSuperView()
        return view
    }

    private func makeContentStackView() -> UIStackView {
        let contentStack = UIStackView(arrangedSubviews: [container, footerLabel])
        contentStack.axis = .vertical
        contentStack.alignment = .trailing
        contentStack.distribution = .fill
        contentStack.spacing = 4

        let hstack = UIStackView(arrangedSubviews: [leftSpacer, avatarContainerView, contentStack, rightSpacer])
        hstack.axis = .horizontal
        hstack.alignment = .top
        hstack.distribution = .fill
        hstack.spacing = Constants.spacing

        let stack = UIStackView(arrangedSubviews: [
            topSpacer,
            header,
            hstack,
            UISpacerView(
                axis: .vertical,
                size: .fixed(value: Constants.spacing),
                color: .clear
            ),
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill

        return stack
    }

    private func makeReplyView() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.Conversation.messageProviderBackgroundColor
        view.nabla.constraintToSize(.init(width: 32, height: 32))
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.alpha = 0

        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowshape.turn.up.left.fill")
        imageView.nabla.constraintToSize(.init(width: 17, height: 14))
        imageView.tintColor = NablaTheme.Conversation.textMessageProviderTextColor
        view.addSubview(imageView)
        imageView.nabla.constraintToCenterInSuperView()

        return view
    }
    
    private func makeContentTapGestureRecognizer() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(contentTapHandler))
        return gesture
    }

    private func makeContentPanGestureRecognizer() -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(contentPanHandler))
        gesture.delegate = self
        return gesture
    }

    private func makeMessagePreviewTapGestureRecognizer() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(messagePreviewTapHandler))
        return gesture
    }
    
    private func setVisibleViews(_ visibleViews: Set<UIView>) {
        // Only add views whose visibility might change.
        [
            topSpacer,
            header,
            avatarView,
            leftSpacer,
            rightSpacer,
        ]
        .forEach { $0.isHidden = !visibleViews.contains($0) }
    }
    
    // MARK: Handlers
    
    @objc private func footerTapHandler() {
        footerTapAction?()
    }
    
    @objc private func contentTapHandler() {
        presenter?.userDidTapContent()
    }

    @objc private func messagePreviewTapHandler() {
        presenter?.userDidTapMessagePreview()
    }

    @objc private func contentPanHandler() {
        let threshold: CGFloat = 40.0
        let state = contentPanGestureRecognizer.state
        if state == .ended {
            UIView.animate(withDuration: 0.2) {
                self.contentStackView.transform = .identity
                self.replyView.transform = .identity
                self.replyView.alpha = 0
            }
            canSendPanGestureToDelegate = true
        } else {
            let translation = contentPanGestureRecognizer.translation(in: content)
            let velocity = contentPanGestureRecognizer.velocity(in: content)
            let isSwipe = abs(velocity.x) > abs(velocity.y)

            guard
                isSwipe,
                translation.x > 0 else {
                return
            }

            let adaptiveTranslation = translation.x / 2

            contentStackView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            replyView.transform = CGAffineTransform(translationX: adaptiveTranslation, y: 0)
            replyView.alpha = min(1, adaptiveTranslation / threshold)

            if adaptiveTranslation >= threshold, canSendPanGestureToDelegate {
                feedbackGenerator.notificationOccurred(.success)
                presenter?.userDidSwipeSuccessfully()
                canSendPanGestureToDelegate = false
            }
        }
    }

    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == contentPanGestureRecognizer {
            return allowSwipeGesture
        }

        return true
    }
}

extension ConversationMessageCell: ConversationContextCell {
    func makeContextMenuConfiguration(for indexPath: IndexPath) -> ContextMenuConfiguration? {
        guard !menuElements.isEmpty else {
            return nil
        }
        return .init(indexPath: indexPath, title: nil, items: menuElements)
    }
    
    func previewForHighlightingContextMenu() -> UITargetedPreview? {
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        parameters.visiblePath = UIBezierPath(
            roundedRect: container.bounds,
            cornerRadius: container.layer.cornerRadius
        )
        return .init(view: container, parameters: parameters)
    }
}
