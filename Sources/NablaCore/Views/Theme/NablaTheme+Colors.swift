import UIKit

public extension NablaTheme {
    enum Colors {
        // MARK: -
        
        public enum Background {
            public static var base: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb000000)
            public static var underCard: UIColor = .nabla.dynamic(lightMode: Palette.rgbF1F4F9, darkMode: Palette.rgb000000)
        }
        
        public enum Text {
            public static var base: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static var subdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb6F787E, darkMode: Palette.rgb9BA0A4)
            public static var placeholder: UIColor = .nabla.dynamic(lightMode: Palette.rgb9BA0A4, darkMode: Palette.rgb6F787E)
            public static var accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static var onAccent: UIColor = Palette.rgbFFFFFF
            public static var onAccentSubdued: UIColor = Palette.rgbDADADA
        }
        
        public enum Fill {
            public static var base: UIColor = .nabla.dynamic(lightMode: Palette.rgbF1F4F9, darkMode: Palette.rgb43484C)
            public static var card: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb1C1C1E)
            public static var subdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb9BA0A4, darkMode: Palette.rgbF1F4F9)
            public static var accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static var accentSubdued: UIColor = Palette.rgbE9F0FF
            public static var danger: UIColor = .nabla.dynamic(lightMode: Palette.rgbFF3A30, darkMode: Palette.rgbC5221F)
        }
        
        public enum Stroke {
            public static var base: UIColor = .nabla.dynamic(lightMode: Palette.rgb43484C, darkMode: Palette.rgb9BA0A4)
            public static var subdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb9BA0A4, darkMode: Palette.rgb6F787E)
            public static var accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static var onAccent: UIColor = Palette.rgbFFFFFF
            public static var danger: UIColor = .nabla.dynamic(lightMode: Palette.rgbFF3A30, darkMode: Palette.rgbC5221F)
        }
        
        public enum ButtonBackground {
            public static var base: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb6F787E)
            public static var baseHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb6F787E)
            public static var baseDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb6F787E)
            public static var accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static var accentHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgb6EB3FF, darkMode: Palette.rgb024D99)
            public static var accentDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgb6EB3FF, darkMode: Palette.rgb024D99)
            public static var accentSubdued: UIColor = .nabla.dynamic(lightMode: Palette.rgbBEDBFB, darkMode: Palette.rgb0A84FF)
            public static var accentSubduedHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgbBEDBFB, darkMode: Palette.rgb0A84FF)
            public static var accentSubduedDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgbBEDBFB, darkMode: Palette.rgb0A84FF)
        }
        
        public enum ButtonText {
            public static var onBase: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static var onBaseHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static var onBaseDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static var onAccent: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgbFFFFFF)
            public static var onAccentHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgbFFFFFF)
            public static var onAccentDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgbFFFFFF)
            public static var onAccentSubdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgbFFFFFF)
            public static var onAccentSubduedHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgbFFFFFF)
            public static var onAccentSubduedDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgbFFFFFF)
        }
        
        // MARK: -

        private enum Palette {
            static let rgbFFFFFF = UIColor(rgb: 0xFFFFFF)
            static let rgbF1F4F9 = UIColor(rgb: 0xF1F4F9)
            static let rgb6F787E = UIColor(rgb: 0x6F787E)
            static let rgb9BA0A4 = UIColor(rgb: 0x9BA0A4)
            static let rgbDADADA = UIColor(rgb: 0xDADADA)
            static let rgb000000 = UIColor(rgb: 0x000000)
            static let rgb43484C = UIColor(rgb: 0x43484C)
            static let rgb1C1C1E = UIColor(rgb: 0x1C1C1E)
            static let rgbE9F0FF = UIColor(rgb: 0xE9F0FF)
            
            static let rgb007AFF = UIColor(rgb: 0x007AFF)
            static let rgb0A84FF = UIColor(rgb: 0x0A84FF)
            static let rgb005ABD = UIColor(rgb: 0x005ABD)
            static let rgb024D99 = UIColor(rgb: 0x024D99)
            static let rgb6EB3FF = UIColor(rgb: 0x6EB3FF)
            static let rgbBEDBFB = UIColor(rgb: 0xBEDBFB)

            static let rgbFF3A30 = UIColor(rgb: 0xFF3A30)
            static let rgbC5221F = UIColor(rgb: 0xC5221F)
        }
    }
}

private extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
