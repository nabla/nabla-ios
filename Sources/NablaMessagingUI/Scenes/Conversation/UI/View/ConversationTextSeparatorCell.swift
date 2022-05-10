import Foundation
import UIKit

final class ConversationTextSeparatorCell: UICollectionViewCell, ConversationTextSeparatorCellContract, Reusable {
    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: - Internal

    func configure(with viewModel: ConversationTextSeparatorCellViewModel) {
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
        label.pinToSuperView(insets: .init(top: 12, leading: 20, bottom: 4, trailing: 20))
    }

    private func makeLabel() -> UILabel {
        let label = UILabel().prepareForAutoLayout()
        label.textAlignment = .center
        label.font = NablaTheme.ConversationTextSeparatorCell.font
        label.textColor = NablaTheme.ConversationTextSeparatorCell.color
        label.numberOfLines = 2
        return label
    }
}

#if DEBUG
    import SwiftUI

    struct ConversationTextSeparatorCell_Previews: PreviewProvider {
        static var preview: ConversationTextSeparatorCell {
            let cell = ConversationTextSeparatorCell(frame: .zero)
            cell.configure(with: .init(text: "Hello ConversationTextSeparatorCell"))
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
