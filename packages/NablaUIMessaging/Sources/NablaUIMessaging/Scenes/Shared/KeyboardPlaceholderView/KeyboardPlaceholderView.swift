import Foundation
import UIKit

/**
 A view that will grow in size to match the size of the keyboard.
 Use `KeyboardPlaceholderView.register(_ textView:)` on any `UITextView` before it becomes the first responder.
 */
public class KeyboardPlaceholderView: UIView {
    // MARK: Life cycle

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        subscribeToKeyboardChanges()
        setUpConstraints()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private

    private var isKeyboardVisible = false

    private lazy var heightConstraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: 0)

    private func observeKeyboardWillShowNotification() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.keyboardWillShowNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.isKeyboardVisible = true
            self?.apply(change: notification.asKeyboardChange())
        }
    }

    private func observeKeyboardWillChangeNotification() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.apply(change: notification.asKeyboardChange())
        }
    }

    private func observeKeyboardWillHideNotification() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.keyboardWillHideNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.isKeyboardVisible = false
            var change = notification.asKeyboardChange()
            change.height = 0
            self?.apply(change: change)
        }
    }

    private func subscribeToKeyboardChanges() {
        observeKeyboardWillShowNotification()
        observeKeyboardWillChangeNotification()
        observeKeyboardWillHideNotification()
    }

    private func setUpConstraints() {
        guard !heightConstraint.isActive else { return }
        prepareForAutoLayout()
        let widthConstraint = widthAnchor.constraint(equalToConstant: 0)
        widthConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint,
        ])
    }

    private var animator: UIViewPropertyAnimator?

    private func apply(change: KeyboardChange) {
        guard isKeyboardVisible else { return }

        heightConstraint.constant = computeOverlappingHeight(keyboardHeight: change.height)

        let animations: () -> Void = {
            self.setNeedsLayout()
            self.superview?.setNeedsLayout()
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }

        guard change.animationDuration > 0 else {
            animations()
            return
        }

        let animator = UIViewPropertyAnimator(
            duration: change.animationDuration,
            curve: change.animationCurve,
            animations: animations
        )
        animator.addCompletion { _ in
            self.animator = nil
        }

        self.animator?.stopAnimation(true)
        animator.startAnimation()
        self.animator = animator
    }

    private func computeOverlappingHeight(keyboardHeight: CGFloat) -> CGFloat {
        guard let parentView = parentViewController?.view else { return keyboardHeight }
        let globalFrame = parentView.convert(bounds, from: self)
        let bottomDistance = parentView.frame.height - globalFrame.maxY
        return max(0, keyboardHeight - bottomDistance)
    }
}
