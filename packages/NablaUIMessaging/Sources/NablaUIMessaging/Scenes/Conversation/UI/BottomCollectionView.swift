import UIKit

final class BottomCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        keyboardDismissMode = .interactive
        contentInsetAdjustmentBehavior = .never
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateInsets()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        updateInsets()
    }

    // MARK: - Private
}

extension UICollectionView {
    func updateInsets() {
        if bounds.height > contentSize.height {
            contentInset = .only(top: bounds.height - contentSize.height)
        } else {
            contentInset = .zero
        }
    }
}
