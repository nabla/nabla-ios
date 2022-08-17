import UIKit

extension NSDirectionalRectEdge: NablaExtendable {}

public extension NablaExtension where Base == NSDirectionalRectEdge {
    static let vertical: NSDirectionalRectEdge = [
        NSDirectionalRectEdge.top,
        NSDirectionalRectEdge.bottom,
    ]
    
    static let horizontal: NSDirectionalRectEdge = [
        NSDirectionalRectEdge.leading,
        NSDirectionalRectEdge.trailing,
    ]
}
