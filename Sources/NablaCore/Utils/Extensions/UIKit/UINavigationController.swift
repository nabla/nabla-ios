import Foundation
import UIKit

public extension NablaExtension where Base: UINavigationController {
    @discardableResult
    func withOpaqueNavigationBarBackground() -> Base {
        let scrollEdgeAppearance = base.navigationBar.scrollEdgeAppearance
            ?? UINavigationBar.appearance().scrollEdgeAppearance?.copy()
            ?? UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithOpaqueBackground()
        base.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        return base
    }
}
