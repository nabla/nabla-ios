import NablaCore
import UIKit

public extension NablaTheme {
    enum CategoryPickerViewTheme {
        public static var backgroundColor: UIColor = NablaTheme.backgroundColor
        
        public static var emptyViewTextColor: UIColor = NablaTheme.primaryTextColor
        public static var emptyViewFont: UIFont = UIFont.nabla.medium(16)
        
        public enum CellTheme {
            public static var textColor: UIColor = NablaTheme.primaryTextColor
            public static var font: UIFont = UIFont.nabla.medium(16)
            public static var borderColor: UIColor = NablaTheme.lightAlternateTextColor
            public static var indicatorColor: UIColor = NablaTheme.primaryTextColor
        }
    }
}
