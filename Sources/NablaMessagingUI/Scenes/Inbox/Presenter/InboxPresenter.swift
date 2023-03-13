import Foundation
import NablaMessagingCore

// sourcery: AutoMockable
protocol InboxPresenter: Presenter {
    @MainActor func userDidTapCreateConversation()
    @MainActor func userDidSelectConversation(_ conversation: Conversation)
}
