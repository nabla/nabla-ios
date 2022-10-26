import NablaCore
import UIKit

public extension NablaTheme {
    struct AppointmentListViewTheme {
        /// Color used for the background of the appointment list view. Default set to NablaTheme.secondaryBackgroundColor
        public static var backgroundColor = NablaTheme.secondaryBackgroundColor
        
        /// Color used for the text of the empty state where no appointments are scheduled. Default set to NablaTheme.primaryTextColor
        public static var emptyViewTextColor: UIColor = NablaTheme.primaryTextColor
        /// Font used for the text of the empty state where no appointments are scheduled. Default set to Medium(16)
        public static var emptyViewFont: UIFont = UIFont.nabla.medium(16)
        
        /// Style of the button used to schedule a new appointment. Default set to NablaTheme.primaryButton
        public static var button = NablaTheme.primaryButton
        
        public enum CellTheme {
            /// Color used for the background of an appointment cell. Default set to NablaTheme.backgroundColor
            public static var backgroundColor = NablaTheme.backgroundColor
            /// Color used for the name of the doctor of an upcoming appointment. Default set to NablaTheme.primaryTextColor
            public static var titleColor = NablaTheme.primaryTextColor
            /// Color used for the name of the doctor of a past appointment. Default set to NablaTheme.secondaryTextColor
            public static var titleDisabledColor = NablaTheme.secondaryTextColor
            /// Font used for the name of the doctor of an appointment. Default set to NablaTheme.body
            public static var titleFont = NablaTheme.body
            /// Color used for the time of an upcoming appointment. Default set to NablaTheme.secondaryTextColor
            public static var subtitleColor = NablaTheme.secondaryTextColor
            /// Color used for the time of a past appointment. Default set to NablaTheme.secondaryTextColor
            public static var subtitleDisabledColor = NablaTheme.secondaryTextColor
            /// Font used for the time of an appointment. Default set to NablaTheme.subhead
            public static var subtitleFont = NablaTheme.subhead
            /// Color of the button to edit an upcoming appointment. Default set to NablaTheme.secondaryTextColor
            public static var moreButtonColor = NablaTheme.secondaryTextColor
            
            /// Style of the button to join an appointment via video call.
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
