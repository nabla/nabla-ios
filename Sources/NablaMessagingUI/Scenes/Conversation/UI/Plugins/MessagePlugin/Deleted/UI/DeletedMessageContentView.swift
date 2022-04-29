import Foundation
import UIKit

final class DeletedMessageContentView: UIView, MessageContentView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addSubview(borderedContainer)
        borderedContainer.pinToSuperView()
        
        borderedContainer.addSubview(label)
        label.pinToSuperView(insets: .init(horizontal: 16, vertical: 8))
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MessageContentView
    
    func configure(with viewModel: DeletedMessageContentViewModel, sender _: ConversationMessageSender) {
        label.text = viewModel.text
    }
    
    func prepareForReuse() {
        label.text = nil
    }
    
    // MARK: - Private
    
    private lazy var label: UILabel = {
        let label = UILabel().prepareForAutoLayout()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textColor = NablaTheme.DeletedMessageContentView.textColor
        label.font = NablaTheme.DeletedMessageContentView.font
        return label
    }()
    
    private lazy var borderedContainer: UIView = {
        let view = UIView().prepareForAutoLayout()
        view.backgroundColor = NablaTheme.DeletedMessageContentView.backgroundColor
        view.layer.borderColor = NablaTheme.DeletedMessageContentView.borderColor.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = NablaTheme.ConversationMessageCell.cornerRadius
        return view
        
    }()
}
