//
//  File.swift
//
//
//  Created by Thibault Tourailles on 23/03/2022.
//

import Foundation
import UIKit

extension UIFont {
    class func regular(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }

    class func medium(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .medium)
    }

    class func semiBold(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    class func bold(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .bold)
    }

    class func light(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .light)
    }

    class func italic(_ size: CGFloat) -> UIFont {
        UIFont.italicSystemFont(ofSize: size)
    }

    class func main(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
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
