import Foundation
import NablaCore
import UIKit

final class TypingIndicatorContentView: UIView, MessageContentView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        addSubview(typingIndicatorView)
        typingIndicatorView.nabla.pinToSuperView(insets: .nabla.make(horizontal: 4, vertical: 2))
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with _: Void) {}
    
    func configure(sender _: ConversationMessageSender) {}
    
    func prepareForReuse() {}
    
    // MARK: - Private
    
    private let typingIndicatorView: TypingIndicatorView = .init()
}
