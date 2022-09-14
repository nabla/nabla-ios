import UIKit

public extension NablaViews.PrimaryButton {
    struct Theme {
        public var backgroundColor: UIColor
        public var highlightedBackgroundColor: UIColor
        public var disabledBackgroundColor: UIColor
        public var textColor: UIColor
        public var font: UIFont
        
        public init(
            backgroundColor: UIColor = NablaTheme.primaryColor,
            highlightedBackgroundColor: UIColor = NablaTheme.lightPrimaryColor,
            disabledBackgroundColor: UIColor = NablaTheme.lightPrimaryColor,
            textColor: UIColor = NablaTheme.alternateTextColor,
            font: UIFont = NablaTheme.body
        ) {
            self.backgroundColor = backgroundColor
            self.highlightedBackgroundColor = highlightedBackgroundColor
            self.disabledBackgroundColor = disabledBackgroundColor
            self.textColor = textColor
            self.font = font
        }
    }
}
