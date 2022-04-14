import Foundation
import UIKit

final class ComposerView: UIView {
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

    var font: UIFont {
        didSet {
            textView.font = font
        }
    }

    var placeHolderFont: UIFont {
        didSet {
            placeHolderLabel.font = placeHolderFont
        }
    }

    // MARK: - Init

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        font = .systemFont(ofSize: 16)
        placeHolderFont = .italicSystemFont(ofSize: 16)

        super.init(frame: .zero)

        addSubview(hStack)
        hStack.pinToSuperView(insets: Constants.hStackMargins)

        addSubview(placeHolderLabel)

        NSLayoutConstraint.activate([
            placeHolderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: Constants.controlsSize / 4),
            placeHolderLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
        ])
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.isScrollEnabled = hasReachedMaximumHeight
    }

    // MARK: - Private

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

    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addMedia, textView, sendButton])
        stackView.spacing = Constants.hStackSpacing
        
        return stackView
    }()

    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.font = placeHolderFont
        label.textColor = .lightGray
        return label
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView().withInteractiveDismiss().prepareForAutoLayout()
        textView.font = font
        textView.constraintHeight(Constants.controlsSize, relation: .greaterThanOrEqual)
        textView.constraintHeight(Constants.maximumHeight, relation: .lessThanOrEqual)
        textView.layer.cornerRadius = Constants.controlsSize / 2
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.textContainerInset = .all(Constants.controlsSize / 4)
        textView.scrollIndicatorInsets = .all(Constants.controlsSize / 4)
        textView.delegate = self
        return textView
    }()

    private lazy var sendButton: UIButton = {
        let sendButton = UIButton().prepareForAutoLayout()
        sendButton.setImage(.init(systemName: "paperplane.fill"), for: .normal)
        sendButton.constraintWidth(Constants.controlsSize)
        sendButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        sendButton.isEnabled = false
        return sendButton
    }()

    private lazy var addMedia: UIButton = {
        let addMediaButton = UIButton().prepareForAutoLayout()
        addMediaButton.setImage(.init(systemName: "plus"), for: .normal)
        addMediaButton.constraintWidth(Constants.controlsSize)
        addMediaButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        return addMediaButton
    }()

    @objc private func didTapOnButton(_ sender: UIButton) {
        if sender == addMedia {
            delegate?.composerViewDidTapOnAddMedia(self)
        } else if sender == sendButton {
            delegate?.composerViewDidTapOnSend(self)
        }
    }
}

extension ComposerView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
        sendButton.isEnabled = !textView.text.isEmpty
    }
}
