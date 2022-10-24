import NablaCore
import UIKit

class TextView: UIView {
    // MARK: - Internal
    
    var text: String {
        get { textView.text }
        set {
            textView.text = newValue
            update()
        }
    }
    
    var font: UIFont? {
        get { textView.font }
        set {
            textView.font = newValue
            placeholderLabel.font = newValue
        }
    }
    
    var textColor: UIColor? {
        get { textView.textColor }
        set { textView.textColor = newValue }
    }
    
    var placeholder: String? {
        get { placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }
    
    var placeholderTextColor: UIColor? {
        get { placeholderLabel.textColor }
        set { placeholderLabel.textColor = newValue }
    }
    
    var textContainerInset: UIEdgeInsets {
        get { textView.textContainerInset }
        set {
            textView.textContainerInset = newValue
            layoutMargins = makePlaceholderMargins(for: newValue)
        }
    }
    
    var isScrollEnabled: Bool {
        get { textView.isScrollEnabled }
        set { textView.isScrollEnabled = newValue }
    }
    
    var verticalScrollIndicatorInsets: UIEdgeInsets {
        get { textView.verticalScrollIndicatorInsets }
        set { textView.verticalScrollIndicatorInsets = newValue }
    }
    
    override var accessibilityIdentifier: String? {
        get { textView.accessibilityIdentifier }
        set { textView.accessibilityIdentifier = newValue }
    }
    
    weak var delegate: TextViewDelegate?
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        textView.sizeThatFits(size)
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // MARK: - Private
    
    private lazy var textView: UITextView = {
        let view = UITextView().nabla.withInteractiveDismiss()
        view.backgroundColor = .clear
        view.delegate = self
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()
    
    private func setUp() {
        addSubview(textView)
        textView.nabla.pinToSuperView()
        
        addSubview(placeholderLabel)
        placeholderLabel.nabla.pin(to: layoutMarginsGuide)
    }
    
    private func makePlaceholderMargins(for textContainerInset: UIEdgeInsets) -> UIEdgeInsets {
        UIEdgeInsets(
            top: textContainerInset.top - 2,
            left: textContainerInset.left + 5,
            bottom: textContainerInset.bottom,
            right: textContainerInset.right
        )
    }
    
    private func update() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

extension TextView: UITextViewDelegate {
    func textViewDidChange(_: UITextView) {
        update()
        delegate?.textViewDidChange(self)
    }
}
