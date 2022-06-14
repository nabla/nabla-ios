import Foundation
import NablaMessagingCore

protocol ReplyToComposerPresenterDelegate: AnyObject {
    func replyToComposerPresenterDidTapCloseButton(_ presenter: ReplyToComposerPresenter)
}

protocol ReplyToComposerPresenter: Presenter {
    func didUpdate(message: ConversationViewMessageItem?)
    func didTapCloseButton()
}
