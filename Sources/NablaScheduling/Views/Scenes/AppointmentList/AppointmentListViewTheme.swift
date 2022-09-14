import NablaCore
import UIKit

public extension NablaTheme {
    struct AppointmentListViewTheme {
        public static var backgroundColor = NablaTheme.secondaryBackgroundColor
        
        public static var emptyViewTextColor: UIColor = NablaTheme.primaryTextColor
        public static var emptyViewFont: UIFont = UIFont.nabla.medium(16)
        
        public static var button = NablaTheme.primaryButton
        
        public enum CellTheme {
            public static var backgroundColor = NablaTheme.backgroundColor
            public static var titleColor = NablaTheme.primaryTextColor
            public static var titleDisabledColor = NablaTheme.secondaryTextColor
            public static var titleFont = NablaTheme.body
            public static var subtitleColor = NablaTheme.secondaryTextColor
            public static var subtitleDisabledColor = NablaTheme.secondaryTextColor
            public static var subtitleFont = NablaTheme.subhead
            public static var moreButtonColor = NablaTheme.secondaryTextColor
            
            public static var button = NablaViews.PrimaryButton.Theme(
                backgroundColor: Assets.Colors.lightBlue.color,
                highlightedBackgroundColor: Assets.Colors.backgroundGrey.color,
                disabledBackgroundColor: Assets.Colors.backgroundGrey.color,
                textColor: NablaTheme.primaryColor,
                font: NablaTheme.body
            )
        }
        
        private init() {}
    }
}
