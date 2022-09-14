import Foundation
import UIKit

public extension NablaExtension where Base: UIFont {
    static func regular(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func medium(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func semiBold(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func light(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func italic(_ size: CGFloat) -> UIFont {
        UIFont.italicSystemFont(ofSize: size)
    }
    
    static func main(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        FontHelper.shared
            .systemFont
            .font(forTextStyle: textStyle)
    }
}

private class FontHelper {
    static let shared = FontHelper()
    
    let systemFont: DynamicFont = {
        do {
            return try DynamicFont(fontName: "SystemFont")
        } catch {
            assertionFailure("Unable to create SystemFont")
            return DynamicFont()
        }
    }()
}
