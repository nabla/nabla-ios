import Foundation
import NablaMessagingCore

// sourcery: AutoMockable
protocol NablaMessagingClientProtocol {
    var logger: Logger { get }

    func createConversation(handler: @escaping (Result<Conversation, NablaError>) -> Void) -> Cancellable

    func watchItems(
        ofConversationWithId conversationId: UUID,
        handler: @escaping (Result<ConversationItems, NablaError>) -> Void
    ) -> PaginatedWatcher

    func setIsTyping(
        _ isTyping: Bool,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable

    func markConversationAsSeen(
        _ conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable

    func watchConversations(handler: @escaping (Result<ConversationList, NablaError>) -> Void) -> PaginatedWatcher

    func watchConversation(
        _ conversationId: UUID,
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable

    func sendMessage(
        _ message: MessageInput,
        replyingToMessageWithId: UUID?,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable

    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable

    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable
}

extension NablaMessagingClient: NablaMessagingClientProtocol {}

extension NablaMessagingClientProtocol {
    func sendMessage(
        _ message: MessageInput,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        sendMessage(message, replyingToMessageWithId: nil, inConversationWithId: conversationId, handler: handler)
    }
}
