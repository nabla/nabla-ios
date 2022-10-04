import Foundation
import NablaCore
import UIKit

final class TextMessageContentView: UIView, MessageContentView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSubview(textView)
        textView.nabla.pinToSuperView(insets: .nabla.all(10))
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: TextMessageContentViewModel) {
        textView.text = viewModel.text
    }
    
    func configure(sender: ConversationMessageSender) {
        switch sender {
        case .me:
            textView.textColor = NablaTheme.Conversation.textMessagePatientTextColor
            textView.linkTextAttributes = [
                .foregroundColor: NablaTheme.Conversation.textMessagePatientTextColor,
                .underlineColor: NablaTheme.Conversation.textMessagePatientTextColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
            ]
        case .them:
            textView.textColor = NablaTheme.Conversation.textMessageProviderTextColor
            textView.linkTextAttributes = [
                .foregroundColor: NablaTheme.Conversation.textMessageProviderTextColor,
                .underlineColor: NablaTheme.Conversation.textMessageProviderTextColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
            ]
        }
    }
    
    func prepareForReuse() {
        textView.text = nil
    }

    // MARK: - Private
    
    private lazy var textView: UITextView = {
        let view = OnlyLinkAttributeClickableUITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.isSelectable = true // required for dataDetectorTypes
        view.backgroundColor = .clear
        view.textContainerInset = .zero
        view.dataDetectorTypes = [.link, .phoneNumber]
        view.font = NablaTheme.Conversation.textMessageFont
        
        return view
    }()
    
    // Extracted from https://stackoverflow.com/a/42645444/2508174
    private class OnlyLinkAttributeClickableUITextView: UITextView {
        override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
            let tapLocation = point.applying(CGAffineTransform(translationX: -textContainerInset.left, y: -textContainerInset.top))
            let characterAtIndex = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            let linkAttributeAtIndex = textStorage.attribute(.link, at: characterAtIndex, effectiveRange: nil)

            // Returns true for points located on linked text
            return linkAttributeAtIndex != nil
        }

        override func becomeFirstResponder() -> Bool {
            // Returning false disables double-tap selection of link text
            false
        }
    }
}
