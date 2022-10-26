import NablaCore
import UIKit

public extension NablaTheme {
    struct TimeSlotPickerViewTheme {
        /// Background color for the time slot picker view. Default set to NablaTheme.backgroundColor
        public static var backgroundColor = NablaTheme.backgroundColor
        
        /// Theme used for the button to continue in the time slot picker view. Default set to NablaTheme.primaryButton
        public static var button = NablaTheme.primaryButton
        
        public enum CellTheme {
            /// Color of the date of a day in the time slot picker view.  Default set to NablaTheme.primaryTextColor
            public static var titleColor = NablaTheme.primaryTextColor
            /// Font of the date of a day in the time slot picker view.  Default set to Medium(16)
            public static var titleFont = UIFont.nabla.medium(16)
            /// Color of the number of slots available for a day in the time slot picker view. Default set to NablaTheme.secondaryTextColor
            public static var subtitleColor = NablaTheme.secondaryTextColor
            /// Font of the number of slots available for a day in the time slot picker view. Default set to NablaTheme.footnote
            public static var subtitleFont = NablaTheme.footnote
            /// Color of the border of the cell for a day in the time slot picker view. Default set to NablaTheme.lightAlternateTextColor
            public static var borderColor = NablaTheme.lightAlternateTextColor
            /// Tint color used for the expend indicator of the cell for a day in the time slot picker view. Default set to NablaTheme.primaryTextColor
            public static var indicatorColor = NablaTheme.primaryTextColor
            
            public enum ButtonTheme {
                /// Color of a time slot time when not selected and the background of a time slot cell when selected. Default set to NablaTheme.primaryColor
                public static var primaryColor = NablaTheme.primaryColor
                /// Color of a time slot time when selected and the background of a time slot cell when not selected. Default set to NablaTheme.alternateTextColor
                public static var secondaryColor = NablaTheme.alternateTextColor
                /// Font of a time slot time. Default set to NablaTheme.body
                public static var font = NablaTheme.body
            }
        }
        
        private init() {}
    }
}
