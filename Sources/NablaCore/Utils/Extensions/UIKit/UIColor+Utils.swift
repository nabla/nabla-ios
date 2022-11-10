import UIKit

public extension NablaExtension where Base: UIColor {
    /// Easily define two colors for both light and dark mode.
    /// - Parameters:
    ///   - lightMode: The color to use in light mode.
    ///   - darkMode: The color to use in dark mode.
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style.
    static func dynamic(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
            
        return UIColor { traitCollection -> UIColor in
            traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
