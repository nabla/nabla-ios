import Foundation
import NablaCore
import UIKit

final class DateSeparatorCell: UICollectionViewCell, Reusable {
    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: - Internal

    func configure(with viewModel: DateSeparatorCellViewModel) {
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
        label.font = NablaTheme.Conversation.dateSeparatorFont
        label.textColor = NablaTheme.Conversation.dateSeparatorColor
        label.numberOfLines = 2
        return label
    }
}

#if DEBUG
    import SwiftUI

    struct DateSeparatorCell_Previews: PreviewProvider {
        static var preview: DateSeparatorCell {
            let cell = DateSeparatorCell(frame: .zero)
            cell.configure(with: .init(text: "12/03/2023 at 8pm"))
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
