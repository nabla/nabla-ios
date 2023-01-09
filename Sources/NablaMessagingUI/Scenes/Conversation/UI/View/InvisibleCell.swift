import NablaCore
import UIKit

final class InvisibleCell: UICollectionViewCell, Reusable {
    // MARK: - Internal
    
    override var intrinsicContentSize: CGSize {
        .zero
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
    
    private func setUp() {
        backgroundColor = .clear
        contentView.heightAnchor.constraint(equalToConstant: 0)
            .nabla.with(priority: .defaultHigh)
            .isActive = true
    }
}
