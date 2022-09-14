import NablaCore
import UIKit

public extension NablaTheme {
    struct TimeSlotPickerViewTheme {
        public static var backgroundColor = NablaTheme.backgroundColor
        
        public static var button = NablaTheme.primaryButton
        
        public enum CellTheme {
            public static var titleColor = NablaTheme.primaryTextColor
            public static var titleFont = UIFont.nabla.medium(16)
            public static var subtitleColor = NablaTheme.secondaryTextColor
            public static var subtitleFont = NablaTheme.footnote
            public static var borderColor = NablaTheme.lightAlternateTextColor
            public static var indicatorColor = NablaTheme.primaryTextColor
            
            public enum ButtonTheme {
                public static var primaryColor = NablaTheme.primaryColor
                public static var secondaryColor = NablaTheme.alternateTextColor
                public static var font = NablaTheme.body
            }
        }
        
        private init() {}
    }
}
