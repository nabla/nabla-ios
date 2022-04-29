import Foundation
import UIKit

final class EventCell: UICollectionViewCell, EventCellContract, Reusable {
    // MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }
    
    // MARK: - Internal
    
    func configure(with viewModel: EventViewModel) {
        label.text = viewModel.message
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
        label.font = .regular(14)
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }
}

#if DEBUG
    import SwiftUI
    
    struct EventCell_Previews: PreviewProvider {
        static var preview: EventCell {
            let cell = EventCell(frame: .zero)
            cell.configure(with: .init(message: "Hello EventCell"))
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
