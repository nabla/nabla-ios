import UIKit

public extension NablaExtension where Base: UIRefreshControl {
    /// Replacement for `base.begingRefreshing()`.
    /// Fixes the color and the animation of the refresh control when being programmatically forced to refresh.
    func beginRefreshing() {
        guard !base.isRefreshing else { return }
        
        guard let scrollView = scrollView else {
            base.beginRefreshing()
            return
        }
        
        scrollView.contentOffset.y -= base.frame.size.height
        base.tintColorDidChange()
        base.beginRefreshing()
    }
    
    private var scrollView: UIScrollView? {
        var iterator: UIView = base
        while let superview = iterator.superview {
            if let scrollView = superview as? UIScrollView {
                return scrollView
            }
            iterator = superview
        }
        return nil
    }
}
