import UIKit

public protocol ConversationViewControllerDelegate: AnyObject {
    @MainActor func conversationViewControllerShouldEnableTapOnTitleView(_ viewController: UIViewController) -> Bool
    @MainActor func conversationViewControllerDidTapTitleView(_ viewController: UIViewController)
}

public extension ConversationViewControllerDelegate {
    func conversationViewControllerShouldEnableTapOnTitleView(_: UIViewController) -> Bool {
        true
    }
}
