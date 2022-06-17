import Foundation
import NablaMessagingCore

// sourcery: AutoMockable
protocol InboxPresenter: Presenter {
    func userDidTapCreateConversation()
    func userDidSelectConversation(_ conversation: Conversation)
}
