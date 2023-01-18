import NablaCore
import UIKit

public extension NablaTheme {
    enum LocationPickerViewTheme {
        /// Background color for the location picker view.
        public static var backgroundColor: UIColor = Colors.Background.underCard
        
        /// Color of the text displayed when there are no categories available.
        public static var emptyViewTextColor: UIColor = Colors.Text.base
        /// Font of the text displayed when there are no categories available.
        public static var emptyViewFont: UIFont = Fonts.caption
        
        public enum CellTheme {
            /// Corner radius used for the background of a location cell.
            public static var cornerRadius = CGFloat(12)
            /// Color of the background of the cell of a location.
            public static var backgroundColor: UIColor = Colors.Fill.card
            /// Color of the text displayed with the name of a location.
            public static var textColor: UIColor = Colors.Text.base
            /// Font of the text displayed with the name of a location.
            public static var font: UIFont = Fonts.subtitleMedium
            /// Color of the text displayed with the name of a location.
            public static var iconColor: UIColor = Colors.Text.base
            /// Tint color used for the tap indicator of the cell of a location.
            public static var indicatorColor: UIColor = Colors.Text.base
        }
    }
}
