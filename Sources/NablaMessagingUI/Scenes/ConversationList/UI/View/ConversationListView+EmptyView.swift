import NablaCore
import UIKit

extension ConversationListView {
    class EmptyView: UIView {
        // MARK: - Internal
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        // MARK: - Private
        
        private lazy var label: UILabel = {
            let view = UILabel()
            view.text = L10n.conversationListEmptyStateLabel
            view.textAlignment = .center
            view.font = NablaTheme.ConversationPreview.EmptyView.font
            view.textColor = NablaTheme.ConversationPreview.EmptyView.textColor
            return view
        }()
        
        private func setUp() {
            addSubview(label)
            label.nabla.pinToSuperView(insets: .nabla.all(16))
        }
    }
}
