import Foundation
import UIKit

public extension NablaExtension where Base == UINavigationController {
    @discardableResult
    func withOpaqueNavigationBarBackground() -> Base {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        base.navigationBar.standardAppearance = appearance
        base.navigationBar.scrollEdgeAppearance = appearance
        base.navigationBar.compactAppearance = appearance

        return base
    }
}
