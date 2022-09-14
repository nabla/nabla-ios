import UIKit

public extension NablaViews.CheckboxView {
    struct Theme {
        public var tintColor: UIColor
        public var checked: StateTheme
        public var unchecked: StateTheme
        
        public struct StateTheme {
            public var borderColor: UIColor
            public var fillcolor: UIColor
            
            public init(
                borderColor: UIColor,
                fillcolor: UIColor
            ) {
                self.borderColor = borderColor
                self.fillcolor = fillcolor
            }
        }
        
        public init(
            tintColor: UIColor = NablaTheme.alternateTextColor,
            checked: StateTheme = StateTheme(
                borderColor: NablaTheme.primaryColor,
                fillcolor: NablaTheme.primaryColor
            ),
            unchecked: StateTheme = StateTheme(
                borderColor: NablaTheme.darkAlternateTextColor,
                fillcolor: .clear
            )
        ) {
            self.tintColor = tintColor
            self.checked = checked
            self.unchecked = unchecked
        }
    }
}
