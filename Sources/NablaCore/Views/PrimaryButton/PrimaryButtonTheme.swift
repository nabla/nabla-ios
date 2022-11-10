import UIKit

public extension NablaViews.PrimaryButton {
    struct Theme {
        public var backgroundColor: UIColor
        public var highlightedBackgroundColor: UIColor
        public var disabledBackgroundColor: UIColor
        public var textColor: UIColor
        public var highlightedTextColor: UIColor
        public var disabledTextColor: UIColor
        public var font: UIFont
        
        public init(
            backgroundColor: UIColor,
            highlightedBackgroundColor: UIColor,
            disabledBackgroundColor: UIColor,
            textColor: UIColor,
            highlightedTextColor: UIColor,
            disabledTextColor: UIColor,
            font: UIFont
        ) {
            self.backgroundColor = backgroundColor
            self.highlightedBackgroundColor = highlightedBackgroundColor
            self.disabledBackgroundColor = disabledBackgroundColor
            self.textColor = textColor
            self.highlightedTextColor = highlightedTextColor
            self.disabledTextColor = disabledTextColor
            self.font = font
        }
    }
}
