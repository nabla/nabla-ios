// swiftlint:disable large_tuple
import Combine
import Foundation
import NablaCore
import NablaMessagingCore
@testable import NablaMessagingUI

final class NablaMessagingClientProtocolMock: NablaMessagingClientProtocol {
    func addRefetchTriggers(_: RefetchTrigger...) {}

    var createConversationReceivedInvocations: [(title: String?, providerIds: [UUID]?, initialMessage: MessageInput?, Void)] = []
    var createConversationClosure: ((_ title: String?, _ providerIds: [UUID]?, _ initialMessage: MessageInput?) async throws -> Conversation)?
    
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: MessageInput?
    ) async throws -> Conversation {
        createConversationReceivedInvocations.append((title: title, providerIds: providerIds, initialMessage: initialMessage, ()))
        if let closure = createConversationClosure {
            return try await closure(title, providerIds, initialMessage)
        } else {
            fatalError("Missing mock for \(#function)")
        }
    }
    
    var createDraftConversationReceivedInvocations: [(title: String?, providerIds: [UUID]?, Void)] = []
    var createDraftConversationClosure: ((_ title: String?, _ providerIds: [UUID]?) -> Conversation)?
    
    func createDraftConversation(title: String?, providerIds: [UUID]?) -> Conversation {
        createDraftConversationReceivedInvocations.append((title: title, providerIds: providerIds, ()))
        return createDraftConversationClosure?(title, providerIds) ?? Conversation.mock()
    }

    var watchItemsReceivedInvocations: [(conversationId: UUID, Void)] = []
    var watchItemsClosure: ((_ conversationId: UUID) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError>)?
    func watchItems(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError> {
        watchItemsReceivedInvocations.append((conversationId: conversationId, ()))
        return watchItemsClosure?(conversationId) ?? Empty().eraseToAnyPublisher()
    }

    var setIsTypingReceivedInvocations: [(isTyping: Bool, conversationId: UUID)] = []
    var setIsTypingClosure: ((_ isTyping: Bool, _ conversationId: UUID) async throws -> Void)?
    func setIsTyping(
        _ isTyping: Bool,
        inConversationWithId conversationId: UUID
    ) async throws {
        setIsTypingReceivedInvocations.append((isTyping: isTyping, conversationId: conversationId))
        if let closure = setIsTypingClosure {
            return try await closure(isTyping, conversationId)
        } else {
            fatalError("Missing mock for \(#function)")
        }
    }

    var markConversationAsSeenReceivedInvocations: [(conversationId: UUID, Void)] = []
    var markConversationAsSeenClosure: ((_ conversationId: UUID) async throws -> Void)?
    func markConversationAsSeen(
        _ conversationId: UUID
    ) async throws {
        markConversationAsSeenReceivedInvocations.append((conversationId: conversationId, ()))
        if let closure = markConversationAsSeenClosure {
            return try await closure(conversationId)
        } else {
            fatalError("Missing mock for \(#function)")
        }
    }

    var watchConversationsParams: [Void] = []
    var watchConversationsClosure: (() -> AnyPublisher<PaginatedList<Conversation>, NablaError>)?
    func watchConversations() -> AnyPublisher<PaginatedList<Conversation>, NablaError> {
        watchConversationsParams.append(())
        return watchConversationsClosure?() ?? Empty().eraseToAnyPublisher()
    }

    var watchConversationParams: [(conversationId: UUID, Void)] = []
    var watchConversationClosure: ((_ conversationId: UUID) -> AnyPublisher<Conversation, NablaError>)?
    func watchConversation(
        withId conversationId: UUID
    ) -> AnyPublisher<Conversation, NablaError> {
        watchConversationParams.append((conversationId: conversationId, ()))
        return watchConversationClosure?(conversationId) ?? Empty().eraseToAnyPublisher()
    }

    var sendMessageParams: [(message: MessageInput, replyTo: UUID?, conversationId: UUID)] = []
    var sendMessageClosure: ((_ message: MessageInput, _ conversationId: UUID) async throws -> Void)?
    func sendMessage(
        _ message: MessageInput,
        replyingToMessageWithId: UUID?,
        inConversationWithId conversationId: UUID
    ) async throws {
        sendMessageParams.append((message: message, replyTo: replyingToMessageWithId, conversationId: conversationId))
        if let closure = sendMessageClosure {
            return try await closure(message, conversationId)
        } else {
            fatalError("Missing mock for \(#function)")
        }
    }

    var retrySendingParams: [(itemId: UUID, conversationId: UUID)] = []
    var retrySendingClosure: ((_ itemId: UUID, _ conversationId: UUID) async throws -> Void)?
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID
    ) async throws {
        retrySendingParams.append((itemId: itemId, conversationId: conversationId))
        if let closure = retrySendingClosure {
            return try await closure(itemId, conversationId)
        } else {
            fatalError("Missing mock for \(#function)")
        }
    }

    var deleteMessageParams: [(messageId: UUID, conversationId: UUID)] = []
    var deleteMessageClosure: ((_ messageId: UUID, _ conversationId: UUID) async throws -> Void)?
    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID
    ) async throws {
        deleteMessageParams.append((messageId: messageId, conversationId: conversationId))
        if let closure = deleteMessageClosure {
            return try await closure(messageId, conversationId)
        } else {
            fatalError("Missing mock for \(#function)")
        }
    }
}

extension NablaMessagingClientProtocolMock {
    static var shared = NablaMessagingClientProtocolMock()
}

extension NablaMessagingClientProtocolMock {
    var views: NablaMessagingViewFactory {
        NablaMessagingViewFactory(client: self, logger: LoggerMock(), videoCallClient: nil)
    }
}
