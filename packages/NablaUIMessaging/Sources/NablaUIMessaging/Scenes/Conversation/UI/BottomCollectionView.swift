import UIKit

final class BottomCollectionView: UICollectionView {
    private var size: CGSize? {
        didSet {
            if let size = size, let oldValue = oldValue, size != oldValue {
                contentOffset.y -= size.height - oldValue.height
                updateInsets()
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        size = bounds.size
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateInsets()
    }

    override func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        let isAtBottomBeforeUpdates = isAtBottom()
        super.performBatchUpdates(updates) { completed in
            completion?(completed)
            if isAtBottomBeforeUpdates {
                self.scrollToBottom()
            }
        }
    }
}

private extension UICollectionView {
    func updateInsets() {
        if bounds.height > contentSize.height {
            contentInset.top = bounds.height - contentSize.height
        } else {
            contentInset.top = 0
        }
    }

    func isAtBottom() -> Bool {
        (contentOffset.y + contentInset.top) >= contentSize.height - bounds.height
    }

    func scrollToBottom(animated: Bool = true) {
        let indexPath = IndexPath(item: numberOfItems(inSection: 0) - 1, section: 0)
        scrollToItem(at: indexPath, at: .bottom, animated: animated)
    }
}
