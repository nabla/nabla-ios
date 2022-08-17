import Foundation
import NablaCore
import UIKit

final class ConversationActivityCell: UICollectionViewCell, Reusable {
    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: - Internal

    func configure(with viewModel: ConversationActivityCellViewModel) {
        label.text = viewModel.text
    }

    func configure(presenter: Presenter) {
        self.presenter = presenter
        presenter.start()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        label.text = nil
    }

    // MARK: - Private

    private var presenter: Presenter?

    private lazy var label: UILabel = makeLabel()

    private func setUp() {
        contentView.addSubview(label)
        label.nabla.pinToSuperView(insets: .init(top: 12, leading: 20, bottom: 4, trailing: 20))
    }

    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = NablaTheme.Conversation.conversationActivityFont
        label.textColor = NablaTheme.Conversation.conversationActivityColor
        label.numberOfLines = 2
        return label
    }
}

#if DEBUG
    import SwiftUI

    struct ConversationActivityCell_Previews: PreviewProvider {
        static var preview: ConversationActivityCell {
            let cell = ConversationActivityCell(frame: .zero)
            cell.configure(with: .init(text: "Provider X joined the conversation"))
            return cell
        }

        static var previews: some View {
            UIViewPreview {
                preview
            }
            .previewLayout(.fixed(width: 300, height: 44))
        }
    }
#endif
