import UIKit

class FlippedCollectionView: UICollectionView {
    // MARK: - Public
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        transform = .flipped
        automaticallyAdjustsScrollIndicatorInsets = false
        observePanLocation()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        transform = .flipped
        automaticallyAdjustsScrollIndicatorInsets = false
        observePanLocation()
    }
    
    override var contentInset: UIEdgeInsets {
        get { flip(super.contentInset) }
        set { super.contentInset = flip(newValue) }
    }
    
    override var adjustedContentInset: UIEdgeInsets { flip(super.adjustedContentInset) }
    
    /// It is not possible to override the equivalent of `adjustedContentInset` for the scrolling indicator.
    /// Instead, we disable `automaticallyAdjustsScrollIndicatorInsets` and handle it manually.
    override var automaticallyAdjustsScrollIndicatorInsets: Bool {
        get { false }
        // swiftlint:disable:next unused_setter_value
        set { super.automaticallyAdjustsScrollIndicatorInsets = false }
    }
    
    override var verticalScrollIndicatorInsets: UIEdgeInsets {
        get {
            var inset = flip(super.verticalScrollIndicatorInsets)
            // See comment on `automaticallyAdjustsScrollIndicatorInsets`
            inset.top += adjustedContentInset.top
            inset.bottom += adjustedContentInset.bottom
            return inset
        }
        set { super.verticalScrollIndicatorInsets = flip(newValue) }
    }
    
    override var horizontalScrollIndicatorInsets: UIEdgeInsets {
        get { flip(super.horizontalScrollIndicatorInsets) }
        set { super.horizontalScrollIndicatorInsets = flip(newValue) }
    }
    
    override var contentOffset: CGPoint {
        get { super.contentOffset }
        set {
            if let panLocation = panLocation, !frame.contains(panLocation) {
                // Stop scrolling when outside of our own frame.
                // Helps behave correctly with UIScrollView.KeyboardDismissMode.interactive
                return
            }
            super.contentOffset = newValue
        }
    }
    
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        super.scrollToItem(at: indexPath, at: flip(scrollPosition), animated: animated)
    }
    
    func scrollToBottomCell(animated: Bool) {
        let bottom = IndexPath(row: 0, section: 0)
        scrollToItem(at: bottom, at: .bottom, animated: animated)
    }
    
    // MARK: - Private
    
    private var panLocation: CGPoint?
    
    private func flip(_ scrollPosition: ScrollPosition) -> ScrollPosition {
        var copy = scrollPosition
        if scrollPosition.contains(.top) {
            copy.remove(.top)
            copy.insert(.bottom)
        }
        if scrollPosition.contains(.bottom) {
            copy.remove(.bottom)
            copy.insert(.top)
        }
        return copy
    }
    
    private func flip(_ edgeInsets: UIEdgeInsets) -> UIEdgeInsets {
        UIEdgeInsets(
            top: edgeInsets.bottom,
            left: edgeInsets.left,
            bottom: edgeInsets.top,
            right: edgeInsets.right
        )
    }
    
    private func observePanLocation() {
        panGestureRecognizer.addTarget(self, action: #selector(panGestureHandler(_:)))
    }
    
    @objc private func panGestureHandler(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began, .changed:
            panLocation = recognizer.location(in: superview)
        default:
            panLocation = nil
        }
    }
}

class FlippedCollectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = super.layoutAttributesForItem(at: indexPath)
        attrs?.transform = .flipped
        return attrs
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrsList = super.layoutAttributesForElements(in: rect)
        if let list = attrsList {
            for i in 0 ..< list.count {
                list[i].transform = .flipped
            }
        }
        return attrsList
    }
}

private extension CGAffineTransform {
    static let flipped = CGAffineTransform(scaleX: 1, y: -1)
}
