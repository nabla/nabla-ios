import Combine
import Foundation
import NablaCore
import NablaMessagingCore

// sourcery: AutoMockable
protocol NablaMessagingClientProtocol {
    func createConversation(
        withMessage message: MessageInput,
        title: String?,
        providerIds: [UUID]?
    ) async throws -> Conversation
    
    func startConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation

    func watchItems(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError>

    func setIsTyping(
        _ isTyping: Bool,
        inConversationWithId conversationId: UUID
    ) async throws

    func markConversationAsSeen(_ conversationId: UUID) async throws

    func watchConversations() -> AnyPublisher<PaginatedList<Conversation>, NablaError>

    func watchConversation(withId conversationId: UUID) -> AnyPublisher<Conversation, NablaError>

    func sendMessage(
        _ message: MessageInput,
        replyingToMessageWithId: UUID?,
        inConversationWithId conversationId: UUID
    ) async throws

    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID
    ) async throws

    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID
    ) async throws
    
    func addRefetchTriggers(_ triggers: RefetchTrigger...)
}

extension NablaMessagingClient: NablaMessagingClientProtocol {}

extension NablaMessagingClientProtocol {
    func sendMessage(
        _ message: MessageInput,
        inConversationWithId conversationId: UUID
    ) async throws {
        try await sendMessage(message, replyingToMessageWithId: nil, inConversationWithId: conversationId)
    }
    
    func createConversation(
        withMessage message: MessageInput,
        title: String?
    ) async throws -> Conversation {
        try await createConversation(
            withMessage: message,
            title: title,
            providerIds: nil
        )
    }
    
    func createConversation(
        withMessage message: MessageInput,
        providerIds: [UUID]?
    ) async throws -> Conversation {
        try await createConversation(
            withMessage: message,
            title: nil,
            providerIds: providerIds
        )
    }
    
    func createConversation(
        withMessage message: MessageInput
    ) async throws -> Conversation {
        try await createConversation(
            withMessage: message,
            title: nil,
            providerIds: nil
        )
    }
    
    func startConversation() -> Conversation {
        startConversation(
            title: nil,
            providerIds: nil
        )
    }
    
    func startConversation(title: String?) -> Conversation {
        startConversation(
            title: title,
            providerIds: nil
        )
    }
}
