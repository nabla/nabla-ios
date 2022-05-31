import AVFoundation
import Foundation
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
    
    private(set) var medias: [Media] = []
    
    // MARK: - Init
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dependencies: Dependencies) {
        logger = dependencies.logger

        super.init(frame: .zero)
        
        addSubview(vStack)
        vStack.pinToSuperView(insets: Constants.hStackMargins)
        
        backgroundColor = NablaTheme.ComposerView.backgroundColor
        addSubview(vStack)
        vStack.pinToSuperView(insets: Constants.hStackMargins)
        
        addSubview(placeHolderLabel)
        
        NSLayoutConstraint.activate([
            placeHolderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: Constants.controlsSize / 4 + 4),
            placeHolderLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
        ])
        
        updateMediaComposerVisibility()
        updateAudioRecordingVisibility()
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
        static let controlsSize: CGFloat = 44
        static let maximumHeight: CGFloat = 124
        static let hStackSpacing: CGFloat = 8
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
        let stackView = UIStackView(arrangedSubviews: [mediaComposerView, hStack])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                deleteAudioRecordingButton,
                recordAudioButton,
                addMedia,
                textView,
                audioRecorderComposerView,
                sendButton,
            ]
        )
        stackView.spacing = Constants.hStackSpacing
        stackView.setCustomSpacing(8, after: recordAudioButton)
        
        return stackView
    }()
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.font = NablaTheme.ComposerView.font
        label.textColor = NablaTheme.ComposerView.textColor.withAlphaComponent(0.5)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView().withInteractiveDismiss().prepareForAutoLayout()
        textView.font = NablaTheme.ComposerView.font
        textView.constraintHeight(Constants.controlsSize, relation: .greaterThanOrEqual)
        textView.constraintHeight(Constants.maximumHeight, relation: .lessThanOrEqual)
        textView.textColor = NablaTheme.ComposerView.textColor
        textView.layer.cornerRadius = Constants.controlsSize / 2
        textView.layer.borderWidth = 1
        textView.layer.borderColor = NablaTheme.ComposerView.accessoryColor.cgColor
        textView.textContainerInset = .all(Constants.controlsSize / 4)
        textView.scrollIndicatorInsets = .all(Constants.controlsSize / 4)
        textView.delegate = self
        textView.backgroundColor = NablaTheme.ComposerView.backgroundColor
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let sendButton = UIButton().prepareForAutoLayout()
        sendButton.setImage(NablaTheme.ComposerView.sendIcon, for: .normal)
        sendButton.constraintWidth(Constants.controlsSize)
        sendButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        sendButton.isEnabled = false
        sendButton.tintColor = NablaTheme.ComposerView.accessoryColor
        return sendButton
    }()
    
    private lazy var addMedia: UIButton = {
        let addMediaButton = UIButton().prepareForAutoLayout()
        addMediaButton.setImage(NablaTheme.ComposerView.addMediaIcon, for: .normal)
        addMediaButton.constraintWidth(Constants.controlsSize)
        addMediaButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        addMediaButton.tintColor = NablaTheme.ComposerView.accessoryColor
        return addMediaButton
    }()

    private lazy var recordAudioButton: UIButton = {
        let addMediaButton = UIButton().prepareForAutoLayout()
        addMediaButton.setImage(NablaTheme.ComposerView.recordAudioIcon, for: .normal)
        addMediaButton.constraintWidth(Constants.controlsSize)
        addMediaButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        addMediaButton.tintColor = NablaTheme.ComposerView.accessoryColor
        return addMediaButton
    }()

    private lazy var deleteAudioRecordingButton: UIButton = {
        let addMediaButton = UIButton().prepareForAutoLayout()
        addMediaButton.setImage(NablaTheme.ComposerView.deleteAudioRecordingIcon, for: .normal)
        addMediaButton.constraintWidth(Constants.controlsSize)
        addMediaButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        addMediaButton.tintColor = NablaTheme.ComposerView.accessoryColor
        return addMediaButton
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
        } else {
            setVisibleViews([addMedia, recordAudioButton, textView, placeHolderLabel])
        }
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
