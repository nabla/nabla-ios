import Foundation
import UIKit

extension UITextView {
    func withInteractiveDismiss() -> Self {
        assert(inputAccessoryView == nil, "Not supported yet")
        inputAccessoryView = InputView()
        return self
    }
    
    private class InputView: UIView {
        init() {
            super.init(frame: .zero)
        }
        
        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var observer: NSKeyValueObservation?
        
        override func willMove(toSuperview newSuperview: UIView?) {
            super.willMove(toSuperview: newSuperview)
            observer = newSuperview?.observe(\.center) { [weak self] superview, _ in
                self?.frameChangeHandler(container: superview)
            }
        }
        
        private func frameChangeHandler(container: UIView) {
            let userInfo: [AnyHashable: Any] = [
                UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: container.frame),
                UIResponder.keyboardAnimationDurationUserInfoKey: CGFloat(0),
            ]
            NotificationCenter.default.post(
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil,
                userInfo: userInfo
            )
        }
    }
}
