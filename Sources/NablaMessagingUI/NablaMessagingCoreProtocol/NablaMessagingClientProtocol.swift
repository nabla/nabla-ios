import Foundation
import NablaCore
import NablaMessagingCore

// sourcery: AutoMockable
protocol NablaMessagingClientProtocol {
    var logger: Logger { get }

    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable
    
    func createDraftConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation

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
    ) -> Watcher

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
    
    func addRefetchTriggers(_ triggers: RefetchTrigger...)
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
    
    func createConversation(
        title: String?,
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable {
        createConversation(title: title, providerIds: nil, handler: handler)
    }
    
    func createConversation(
        providerIds: [UUID]?,
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable {
        createConversation(title: nil, providerIds: providerIds, handler: handler)
    }
    
    func createConversation(
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable {
        createConversation(
            title: nil,
            providerIds: nil,
            handler: handler
        )
    }
    
    func createDraftConversation() -> Conversation {
        createDraftConversation(
            title: nil,
            providerIds: nil
        )
    }
    
    func createDraftConversation(title: String?) -> Conversation {
        createDraftConversation(
            title: title,
            providerIds: nil
        )
    }
}
