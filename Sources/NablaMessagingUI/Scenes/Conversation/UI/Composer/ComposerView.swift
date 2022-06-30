import AVFoundation
import Foundation
import NablaCore
import NablaMessagingCore
import UIKit

final class ComposerView: UIView {
    struct Dependencies {
        let logger: Logger
    }

    // MARK: - Internal
    
    weak var delegate: ComposerViewDelegate?
    
    var text: String? {
        get { textView.text }
        set {
            textView.isScrollEnabled = false
            textView.text = newValue
            textViewDidChange(textView)
            textView.sizeToFit()
        }
    }
    
    var placeHolder: String? {
        get {
            placeHolderLabel.text
        }
        set {
            placeHolderLabel.text = newValue
        }
    }
    
    var showRecordAudioButton = true {
        didSet { updateAudioRecordingVisibility() }
    }
    
    private(set) var medias: [Media] = []

    var replyToMessage: ConversationViewMessageItem? {
        didSet {
            replyToComposerView.message = replyToMessage
            updateReplyToComposerVisibility()
        }
    }
    
    // MARK: - Init
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dependencies: Dependencies) {
        logger = dependencies.logger

        super.init(frame: .zero)

        backgroundColor = NablaTheme.Conversation.composerBackgroundColor
        addSubview(vStack)
        vStack.pinToSuperView()
        
        addSubview(placeHolderLabel)
        
        NSLayoutConstraint.activate([
            placeHolderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: Constants.controlsSize / 4 + 4),
            placeHolderLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
        ])
        
        updateMediaComposerVisibility()
        updateAudioRecordingVisibility()
        updateReplyToComposerVisibility()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.isScrollEnabled = hasReachedMaximumHeight
    }

    // MARK: - Public

    func emptyComposer() {
        text = nil
        mediaComposerView.emptyMedias()
        replyToMessage = nil
    }

    func add(_ medias: [Media]) {
        self.medias.append(contentsOf: medias)
        mediaComposerView.add(medias)
    }
    
    // MARK: - Private

    private let logger: Logger
    
    private var enableSendButton: Bool {
        !text.isBlank || !medias.isEmpty || isRecording
    }
    
    private enum Constants {
        static let controlsSize: CGFloat = 24
        static let textViewMinHeight: CGFloat = 44
        static let maximumHeight: CGFloat = 124
        static let hStackSpacing: CGFloat = 4
        static let hStackMargins: NSDirectionalEdgeInsets = .init(horizontal: Constants.unit * 4, vertical: Constants.unit)
        private static let unit: CGFloat = 4
    }
    
    private var hasReachedMaximumHeight: Bool {
        let maximumWidth = textView.frame.width
        let constraintedSize = CGSize(width: maximumWidth, height: 0)
        let idealSize = textView.sizeThatFits(constraintedSize)
        return idealSize.height >= Constants.maximumHeight
    }

    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [replyToComposerView, hStack])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var hStack: UIView = {
        let container = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [
                addMedia,
                deleteAudioRecordingButton,
                recordAudioButton,
                borderedContainerView,
                audioRecorderComposerView,
                sendButton,
            ]
        )
        stackView.spacing = Constants.hStackSpacing
        stackView.setCustomSpacing(8, after: recordAudioButton)

        container.addSubview(stackView)
        stackView.pinToSuperView(insets: Constants.hStackMargins)
        
        return container
    }()

    private lazy var borderedContainerView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [mediaComposerView, textView])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = Constants.textViewMinHeight / 2
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = NablaTheme.Conversation.composerButtonTintColor.cgColor
        return stackView
    }()
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.font = NablaTheme.Conversation.composerFont
        label.textColor = NablaTheme.Conversation.composerTextColor.withAlphaComponent(0.5)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView().withInteractiveDismiss().prepareForAutoLayout()
        textView.font = NablaTheme.Conversation.composerFont
        textView.constraintHeight(Constants.textViewMinHeight, relation: .greaterThanOrEqual)
        textView.constraintHeight(Constants.maximumHeight, relation: .lessThanOrEqual)
        textView.textColor = NablaTheme.Conversation.composerTextColor
        textView.textContainerInset = .all(Constants.textViewMinHeight / 4)
        textView.scrollIndicatorInsets = .all(Constants.textViewMinHeight / 4)
        textView.delegate = self
        textView.backgroundColor = NablaTheme.Conversation.composerBackgroundColor
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let sendButton = UIButton().prepareForAutoLayout()
        sendButton.setImage(NablaTheme.Conversation.sendIcon, for: .normal)
        sendButton.setImage(NablaTheme.Conversation.sendIconDisabled, for: .disabled)
        sendButton.constraintWidth(Constants.controlsSize)
        sendButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        sendButton.isEnabled = false
        sendButton.tintColor = NablaTheme.Conversation.composerButtonTintColor
        return sendButton
    }()
    
    private lazy var addMedia: UIButton = {
        let button = UIButton().prepareForAutoLayout()
        button.setImage(NablaTheme.Conversation.addMediaIcon, for: .normal)
        button.constraintWidth(Constants.controlsSize)
        button.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        button.tintColor = NablaTheme.Conversation.composerButtonTintColor
        return button
    }()

    private lazy var recordAudioButton: UIButton = {
        let button = UIButton().prepareForAutoLayout()
        button.setImage(NablaTheme.Conversation.recordAudioIcon, for: .normal)
        button.constraintWidth(Constants.controlsSize)
        button.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        button.tintColor = NablaTheme.Conversation.composerButtonTintColor
        return button
    }()

    private lazy var deleteAudioRecordingButton: UIButton = {
        let button = UIButton().prepareForAutoLayout()
        button.setImage(NablaTheme.Conversation.deleteAudioRecordingIcon, for: .normal)
        button.constraintWidth(Constants.controlsSize)
        button.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        button.tintColor = NablaTheme.Conversation.composerButtonTintColor
        return button
    }()
    
    private lazy var mediaComposerView: MediaComposerView = {
        let view = MediaComposerView()
        let presenter = MediaComposerPresenterImplementation(viewContract: view, delegate: self)
        view.presenter = presenter
        
        view.constraintHeight(70.0)
        return view
    }()

    private lazy var audioRecorderComposerView: AudioRecorderComposerView = {
        let view = AudioRecorderComposerView()
        let presenter = AudioRecorderComposerPresenterImpl(viewContract: view, dependencies: .init(logger: logger))
        presenter.delegate = self
        view.presenter = presenter

        return view
    }()

    private lazy var replyToComposerView: ReplyToComposerView = {
        let view = ReplyToComposerView()
        let presenter = ReplyToComposerPresenterImpl(viewContract: view, dependencies: .init(logger: logger))
        presenter.delegate = self
        view.presenter = presenter

        return view
    }()

    private var isRecording = false {
        didSet {
            updateAudioRecordingVisibility()
            sendButton.isEnabled = enableSendButton
        }
    }
    
    private func updateMediaComposerVisibility() {
        mediaComposerView.isHidden = medias.isEmpty
    }

    private func updateAudioRecordingVisibility() {
        if isRecording {
            setVisibleViews([deleteAudioRecordingButton, audioRecorderComposerView])
        } else if showRecordAudioButton {
            setVisibleViews([recordAudioButton, addMedia, textView, placeHolderLabel])
        } else {
            setVisibleViews([addMedia, textView, placeHolderLabel])
        }
    }

    private func updateReplyToComposerVisibility() {
        replyToComposerView.isHidden = replyToMessage == nil
    }

    private func setVisibleViews(_ visibleViews: Set<UIView>) {
        // Only add views whose visibility might change.
        [
            deleteAudioRecordingButton,
            addMedia,
            recordAudioButton,
            textView,
            placeHolderLabel,
            audioRecorderComposerView,
        ]
        .forEach { $0.isHidden = !visibleViews.contains($0) }
    }
    
    @objc private func didTapOnButton(_ sender: UIButton) {
        if sender == addMedia {
            delegate?.composerViewDidTapOnAddMedia(self)
        } else if sender == sendButton {
            // TODO: @tgy fix view to view data flow
            if isRecording {
                audioRecorderComposerView.stopRecording()
            } else {
                delegate?.composerViewDidTapOnSend(self)
            }
        } else if sender == recordAudioButton {
            audioRecorderComposerView.startRecording()
        } else if sender == deleteAudioRecordingButton {
            audioRecorderComposerView.cancelRecording()
        }
    }
}

extension ComposerView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
        sendButton.isEnabled = enableSendButton
        delegate?.composerViewDidUpdateTextDraft(self)
    }
}

extension ComposerView: MediaComposerPresenterDelegate {
    // MARK: - MediaComposerPresenterDelegate

    func mediaComposerPresenter(_: MediaComposerPresenter,
                                didUpdateMedias medias: [Media]) {
        self.medias = medias
        sendButton.isEnabled = enableSendButton
        updateMediaComposerVisibility()
    }
}

extension ComposerView: AudioRecorderComposerPresenterDelegate {
    // MARK: - AudioRecorderComposerPresenterDelegate

    func audioRecorderComposerPresenterDidStartRecording(_: AudioRecorderComposerPresenter) {
        isRecording = true
    }

    func audioRecorderComposerPresenter(_: AudioRecorderComposerPresenter, didStopRecordingWithFile file: AudioFile) {
        isRecording = false
        delegate?.composerView(self, didFinishRecordingAudioFile: file)
    }

    func audioRecorderComposerPresenterCanNotStartRecording(_: AudioRecorderComposerPresenter) {
        isRecording = false
    }

    func audioRecorderComposerPresenterDidCancelRecording(_: AudioRecorderComposerPresenter) {
        isRecording = false
    }
}

extension ComposerView: ReplyToComposerPresenterDelegate {
    // MARK: - ReplyToComposerPresenterDelegate

    func replyToComposerPresenterDidTapCloseButton(_: ReplyToComposerPresenter) {
        replyToMessage = nil
    }
}
