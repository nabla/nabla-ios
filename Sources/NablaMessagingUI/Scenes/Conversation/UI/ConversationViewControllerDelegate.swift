import UIKit

public protocol ConversationViewControllerDelegate: AnyObject {
    func conversationViewControllerShouldEnableTapOnTitleView(_ viewController: UIViewController) -> Bool
    func conversationViewControllerDidTapTitleView(_ viewController: UIViewController)
}

public extension ConversationViewControllerDelegate {
    func conversationViewControllerShouldEnableTapOnTitleView(_: UIViewController) -> Bool {
        true
    }
}
