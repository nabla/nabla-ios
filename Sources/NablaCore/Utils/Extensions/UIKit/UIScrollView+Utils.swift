import UIKit

public extension NablaExtension where Base: UIScrollView {
    var isScrollAtBottom: Bool {
        isScrollAtBottom(offset: 0)
    }
    
    func isScrollAtBottom(offset: CGFloat) -> Bool {
        base.contentOffset.y + base.frame.height + base.adjustedContentInset.nabla.vertical >= base.contentSize.height - offset
    }
    
    var contentDoesFitFrame: Bool {
        base.frame.height > base.adjustedContentInset.nabla.vertical + base.contentSize.height
    }
}
