import NablaCore
import UIKit

extension AppointmentConfirmationViewController {
    final class CheckboxFieldView: UIView, UITextViewDelegate {
        // MARK: - Internal
        
        var isChecked: Bool {
            get { checkBox.isChecked }
            set { checkBox.isChecked = newValue }
        }
        
        var attributedText: NSAttributedString? {
            get { textView.attributedText }
            set { textView.attributedText = newValue }
        }
        
        var enableTapOnTextToCheck: Bool {
            get { textTapGestureRecognizer != nil }
            set {
                if newValue {
                    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
                    textTapGestureRecognizer = gestureRecognizer
                    textView.addGestureRecognizer(gestureRecognizer)
                    textView.isSelectable = false
                } else {
                    if let gestureRecognizer = textTapGestureRecognizer {
                        textView.removeGestureRecognizer(gestureRecognizer)
                    }
                    
                    textTapGestureRecognizer = nil
                    textView.isSelectable = true
                }
            }
        }
        
        var onTap: (() -> Void)?
        
        func textView(_: UITextView, shouldInteractWith URL: URL, in _: NSRange, interaction _: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL)
            return false
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
        
        private var textTapGestureRecognizer: UITapGestureRecognizer?
        
        // MARK: Subviews
        
        private lazy var textView: UITextView = {
            let view = UITextView()
            view.isEditable = false
            view.isScrollEnabled = false
            view.textAlignment = .natural
            view.backgroundColor = .clear
            view.textColor = NablaTheme.AppointmentConfirmationTheme.disclaimersTextColor
            view.font = NablaTheme.AppointmentConfirmationTheme.disclaimersFont
            view.textContainerInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
            return view
        }()
        
        private lazy var checkBox: NablaViews.CheckboxView = {
            let view = NablaViews.CheckboxView()
            view.nabla.constraintToSize(20)
            view.theme = NablaTheme.AppointmentConfirmationTheme.checkbox
            return view
        }()
        
        private func setUp() {
            let hstack = UIStackView(arrangedSubviews: [checkBox, textView])
            hstack.axis = .horizontal
            hstack.distribution = .fill
            hstack.alignment = .leading
            hstack.spacing = 8
            addSubview(hstack)
            hstack.nabla.pinToSuperView()
            
            checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
            textView.delegate = self
        }
        
        // MARK: Handlers

        @objc private func tapHandler() {
            onTap?()
        }
    }
}
