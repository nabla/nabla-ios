import NablaCore
import UIKit

public extension NablaTheme {
    enum CategoryPickerViewTheme {
        /// Background color for the category picker view. Default set to NablaTheme.backgroundColor
        public static var backgroundColor: UIColor = NablaTheme.backgroundColor
        
        /// Color of the text displayed when there are no categories available. Default set to NablaTheme.primaryTextColor
        public static var emptyViewTextColor: UIColor = NablaTheme.primaryTextColor
        /// Font of the text displayed when there are no categories available. Default set to Medium(16)
        public static var emptyViewFont: UIFont = UIFont.nabla.medium(16)
        
        public enum CellTheme {
            /// Color of the text displayed with the name of a category.  Default set to NablaTheme.primaryTextColor
            public static var textColor: UIColor = NablaTheme.primaryTextColor
            /// Font of the text displayed with the name of a category. Default set to Medium(16)
            public static var font: UIFont = UIFont.nabla.medium(16)
            /// Color of the border of the cell of a category. Default set to NablaTheme.lightAlternateTextColor
            public static var borderColor: UIColor = NablaTheme.lightAlternateTextColor
            /// Tint color used for the tap indicator of the cell of a category. Default set to NablaTheme.primaryTextColor
            public static var indicatorColor: UIColor = NablaTheme.primaryTextColor
        }
    }
}
