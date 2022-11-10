import UIKit

public extension NablaViews.CheckboxView {
    struct Theme {
        public var tintColor: UIColor
        public var checked: StateTheme
        public var unchecked: StateTheme
        
        public struct StateTheme {
            public var borderColor: UIColor
            public var fillColor: UIColor
            
            public init(
                borderColor: UIColor,
                fillColor: UIColor
            ) {
                self.borderColor = borderColor
                self.fillColor = fillColor
            }
        }
        
        public init(
            tintColor: UIColor,
            checked: StateTheme,
            unchecked: StateTheme
        ) {
            self.tintColor = tintColor
            self.checked = checked
            self.unchecked = unchecked
        }
    }
}
