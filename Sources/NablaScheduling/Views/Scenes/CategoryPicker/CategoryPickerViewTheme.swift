import NablaCore
import UIKit

public extension NablaTheme {
    enum CategoryPickerViewTheme {
        /// Background color for the category picker view.
        public static var backgroundColor: UIColor = Colors.Background.underCard
        
        /// Color of the text displayed when there are no categories available.
        public static var emptyViewTextColor: UIColor = Colors.Text.base
        /// Font of the text displayed when there are no categories available.
        public static var emptyViewFont: UIFont = Fonts.caption
        
        public enum CellTheme {
            /// Color of the background of the cell of a category.
            public static var backgroundColor: UIColor = Colors.Fill.card
            /// Color of the text displayed with the name of a category.
            public static var textColor: UIColor = Colors.Text.base
            /// Font of the text displayed with the name of a category.
            public static var font: UIFont = Fonts.subtitleMedium
            /// Tint color used for the tap indicator of the cell of a category.
            public static var indicatorColor: UIColor = Colors.Text.base
        }
    }
}
