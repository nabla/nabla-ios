import NablaCore
import UIKit

public extension NablaTheme {
    struct TimeSlotPickerViewTheme {
        /// Background color for the time slot picker view.
        public static var backgroundColor = Colors.Background.underCard
        
        /// Theme used for the button to continue in the time slot picker view.
        public static var button = Button.accent
        
        public enum CellTheme {
            /// Color of the background of the cell for a day in the time slot picker view.
            public static var backgroundColor = Colors.Fill.card
            /// Color of the date of a day in the time slot picker view.
            public static var titleColor = Colors.Text.base
            /// Font of the date of a day in the time slot picker view.
            public static var titleFont = Fonts.subtitleMedium
            /// Color of the number of slots available for a day in the time slot picker view.
            public static var subtitleColor = Colors.Text.subdued
            /// Font of the number of slots available for a day in the time slot picker view.
            public static var subtitleFont = Fonts.smallText
            /// Tint color used for the expend indicator of the cell for a day in the time slot picker view.
            public static var indicatorColor = Colors.Text.subdued
            
            public enum ButtonTheme {
                /// Background color of a time slot time when not selected.
                public static var backgroundColor = UIColor.clear
                /// Border color of a time slot time when not selected.
                public static var borderColor = Colors.Stroke.subdued
                /// Text color of a time slot time when not selected.
                public static var textColor = Colors.Text.subdued
                
                /// Background color of a time slot time when selected.
                public static var selectedBackgroundColor = Colors.Fill.accent
                /// Background color of a time slot time when selected.
                public static var selectedBorderColor = Colors.Stroke.accent
                /// Background color of a time slot time when selected.
                public static var selectedTextColor = Colors.Text.onAccent
                /// Font of a time slot time.
                public static var font = Fonts.caption
            }
        }
        
        private init() {}
    }
}
