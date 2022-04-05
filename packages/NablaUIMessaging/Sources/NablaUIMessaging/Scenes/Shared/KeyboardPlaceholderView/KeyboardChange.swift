import Foundation
import UIKit

struct KeyboardChange {
    var height: CGFloat
    var animationDuration: TimeInterval
    var animationCurve: UIView.AnimationCurve
}

extension Notification {
    var keyboardHeight: CGFloat {
        let rawValue = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        return rawValue?.height ?? 0
    }

    var keyboardAnimationDuration: TimeInterval {
        let rawValue = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber ?? 0
        return TimeInterval(truncating: rawValue)
    }

    var keyboardAnimationCurve: UIView.AnimationCurve {
        let rawValue = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber ?? 0
        return UIView.AnimationCurve(rawValue: rawValue.intValue) ?? .easeOut
    }

    func asKeyboardChange() -> KeyboardChange {
        .init(
            height: keyboardHeight,
            animationDuration: keyboardAnimationDuration,
            animationCurve: keyboardAnimationCurve
        )
    }
}
