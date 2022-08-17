import Foundation
import NablaCore
import UIKit

final class DeletedMessageContentView: UIView, MessageContentView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addSubview(borderedContainer)
        borderedContainer.nabla.pinToSuperView()
        
        borderedContainer.addSubview(label)
        label.nabla.pinToSuperView(insets: .nabla.make(horizontal: 16, vertical: 8))
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: DeletedMessageContentViewModel) {
        label.text = viewModel.text
    }
    
    func configure(sender: ConversationMessageSender) {}
    
    func prepareForReuse() {
        label.text = nil
    }
    
    // MARK: - Private
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textColor = NablaTheme.Conversation.deletedMessagetextColor
        label.font = NablaTheme.Conversation.deletedMessagefont
        return label
    }()
    
    private lazy var borderedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = NablaTheme.Conversation.deletedMessagebackgroundColor
        view.layer.borderColor = NablaTheme.Conversation.deletedMessageBorderColor.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = NablaTheme.Conversation.messageCornerRadius
        return view
        
    }()
}
