import UIKit

public extension NablaTheme {
    enum Colors {
        // MARK: -
        
        public enum Background {
            public static let base: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb000000)
            public static let underCard: UIColor = .nabla.dynamic(lightMode: Palette.rgbF1F4F9, darkMode: Palette.rgb000000)
        }
        
        public enum Text {
            public static let base: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static let subdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb6F787E, darkMode: Palette.rgb9BA0A4)
            public static let placeholder: UIColor = .nabla.dynamic(lightMode: Palette.rgb9BA0A4, darkMode: Palette.rgb6F787E)
            public static let accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static let onAccent: UIColor = Palette.rgbFFFFFF
            public static let onAccentSubdued: UIColor = Palette.rgbDADADA
        }
        
        public enum Fill {
            public static let base: UIColor = .nabla.dynamic(lightMode: Palette.rgbF1F4F9, darkMode: Palette.rgb43484C)
            public static let card: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb1C1C1E)
            public static let subdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb9BA0A4, darkMode: Palette.rgbF1F4F9)
            public static let accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static let accentSubdued: UIColor = Palette.rgbE9F0FF
            public static let danger: UIColor = .nabla.dynamic(lightMode: Palette.rgbFF3A30, darkMode: Palette.rgbC5221F)
        }
        
        public enum Stroke {
            public static let base: UIColor = .nabla.dynamic(lightMode: Palette.rgb43484C, darkMode: Palette.rgb9BA0A4)
            public static let subdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb9BA0A4, darkMode: Palette.rgb6F787E)
            public static let accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static let onAccent: UIColor = Palette.rgbFFFFFF
            public static let danger: UIColor = .nabla.dynamic(lightMode: Palette.rgbFF3A30, darkMode: Palette.rgbC5221F)
        }
        
        public enum ButtonBackground {
            public static let base: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb6F787E)
            public static let baseHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb6F787E)
            public static let baseDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgb6F787E)
            public static let accent: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgb0A84FF)
            public static let accentHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgb6EB3FF, darkMode: Palette.rgb024D99)
            public static let accentDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgb6EB3FF, darkMode: Palette.rgb024D99)
            public static let accentSubdued: UIColor = .nabla.dynamic(lightMode: Palette.rgbBEDBFB, darkMode: Palette.rgb0A84FF)
            public static let accentSubduedHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgbBEDBFB, darkMode: Palette.rgb0A84FF)
            public static let accentSubduedDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgbBEDBFB, darkMode: Palette.rgb0A84FF)
        }
        
        public enum ButtonText {
            public static let onBase: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static let onBaseHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static let onBaseDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgb000000, darkMode: Palette.rgbFFFFFF)
            public static let onAccent: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgbFFFFFF)
            public static let onAccentHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgbFFFFFF)
            public static let onAccentDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgbFFFFFF, darkMode: Palette.rgbFFFFFF)
            public static let onAccentSubdued: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgbFFFFFF)
            public static let onAccentSubduedHighlighted: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgbFFFFFF)
            public static let onAccentSubduedDisabled: UIColor = .nabla.dynamic(lightMode: Palette.rgb007AFF, darkMode: Palette.rgbFFFFFF)
        }
        
        // MARK: -

        private enum Palette {
            public static let rgbFFFFFF = UIColor(rgb: 0xFFFFFF)
            public static let rgbF1F4F9 = UIColor(rgb: 0xF1F4F9)
            public static let rgb6F787E = UIColor(rgb: 0x6F787E)
            public static let rgb9BA0A4 = UIColor(rgb: 0x9BA0A4)
            public static let rgbDADADA = UIColor(rgb: 0xDADADA)
            public static let rgb000000 = UIColor(rgb: 0x000000)
            public static let rgb43484C = UIColor(rgb: 0x43484C)
            public static let rgb1C1C1E = UIColor(rgb: 0x1C1C1E)
            public static let rgbE9F0FF = UIColor(rgb: 0xE9F0FF)
            
            public static let rgb007AFF = UIColor(rgb: 0x007AFF)
            public static let rgb0A84FF = UIColor(rgb: 0x0A84FF)
            public static let rgb005ABD = UIColor(rgb: 0x005ABD)
            public static let rgb024D99 = UIColor(rgb: 0x024D99)
            public static let rgb6EB3FF = UIColor(rgb: 0x6EB3FF)
            public static let rgbBEDBFB = UIColor(rgb: 0xBEDBFB)

            public static let rgbFF3A30 = UIColor(rgb: 0xFF3A30)
            public static let rgbC5221F = UIColor(rgb: 0xC5221F)
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
