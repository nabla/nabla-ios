import Combine
import Foundation
import NablaCore
import NablaMessagingCore

// sourcery: AutoMockable
protocol NablaMessagingClientProtocol {
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: MessageInput?
    ) async throws -> Conversation
    
    func createDraftConversation(
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
        title: String?
    ) async throws -> Conversation {
        try await createConversation(
            title: title,
            providerIds: nil,
            initialMessage: nil
        )
    }
    
    func createConversation(
        providerIds: [UUID]?
    ) async throws -> Conversation {
        try await createConversation(
            title: nil,
            providerIds: providerIds,
            initialMessage: nil
        )
    }
    
    func createConversation() async throws -> Conversation {
        try await createConversation(
            title: nil,
            providerIds: nil,
            initialMessage: nil
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
