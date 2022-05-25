// swiftlint:disable large_tuple
import Foundation
import NablaMessagingCore
@testable import NablaMessagingUI

final class NablaMessagingClientProtocolMock: NablaMessagingClientProtocol {
    var logger: Logger = LoggerMock()

    var createConversationCallCount = 0
    var createConversationParams: [(handler: (Result<Conversation, NablaError>) -> Void, Void)] = []
    var createConversationClosure: ((_ handler: @escaping (Result<Conversation, NablaError>) -> Void) -> Cancellable?)?
    func createConversation(
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable {
        createConversationCallCount += 1
        createConversationParams.append((handler: handler, ()))
        return createConversationClosure?(handler) ?? CancellableMock()
    }

    var watchItemsCallCount = 0
    var watchItemsParams: [(conversationId: UUID, handler: (Result<ConversationItems, NablaError>) -> Void, Void)] = []
    var watchItemsResult: PaginatedWatcherMock?
    func watchItems(
        ofConversationWithId conversationId: UUID,
        handler: @escaping (Result<ConversationItems, NablaError>) -> Void
    ) -> PaginatedWatcher {
        watchItemsCallCount += 1
        watchItemsParams.append((conversationId: conversationId, handler: handler, ()))
        return watchItemsResult ?? PaginatedWatcherMock()
    }

    var setIsTypingCallCount = 0
    var setIsTypingParams: [(isTyping: Bool, conversationId: UUID, handler: (Result<Void, NablaError>) -> Void, Void)] = []
    var setIsTypingResult: Cancellable?
    func setIsTyping(
        _ isTyping: Bool,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        setIsTypingCallCount += 1
        setIsTypingParams.append((isTyping: isTyping, conversationId: conversationId, handler: handler, ()))
        return setIsTypingResult ?? CancellableMock()
    }

    var markConversationAsSeenCallCount = 0
    var markConversationAsSeenParams: [(conversationId: UUID, handler: (Result<Void, NablaError>) -> Void, Void)] = []
    var markConversationAsSeenResult: Cancellable?
    func markConversationAsSeen(
        _ conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        markConversationAsSeenCallCount += 1
        markConversationAsSeenParams.append((conversationId: conversationId, handler: handler, ()))
        return markConversationAsSeenResult ?? CancellableMock()
    }

    var watchConversationsCallCount = 0
    var watchConversationsParams: [(handler: (Result<ConversationList, NablaError>) -> Void, Void)] = []
    var watchConversationsClosure: ((_ handler: @escaping (Result<ConversationList, NablaError>) -> Void) -> PaginatedWatcher)?
    func watchConversations(
        handler: @escaping (Result<ConversationList, NablaError>) -> Void
    ) -> PaginatedWatcher {
        watchConversationsCallCount += 1
        watchConversationsParams.append((handler: handler, ()))
        return watchConversationsClosure?(handler) ?? PaginatedWatcherMock()
    }

    var watchConversationCallCount = 0
    var watchConversationParams: [(conversationId: UUID, handler: (Result<Conversation, NablaError>) -> Void, Void)] = []
    var watchConversationResult: Cancellable?
    func watchConversation(
        _ conversationId: UUID,
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable {
        watchConversationCallCount += 1
        watchConversationParams.append((conversationId: conversationId, handler: handler, ()))
        return watchConversationResult ?? CancellableMock()
    }

    var sendMessageCallCount = 0
    var sendMessageParams: [(message: MessageInput, conversationId: UUID, handler: (Result<Void, NablaError>) -> Void, Void)] = []
    var sendMessageResult: Cancellable?
    func sendMessage(
        _ message: MessageInput,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        sendMessageCallCount += 1
        sendMessageParams.append((message: message, conversationId: conversationId, handler: handler, ()))
        return sendMessageResult ?? CancellableMock()
    }

    var retrySendingCallCount = 0
    var retrySendingParams: [(itemId: UUID, conversationId: UUID, handler: (Result<Void, NablaError>) -> Void, Void)] = []
    var retrySendingResult: Cancellable?
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        retrySendingCallCount += 1
        retrySendingParams.append((itemId: itemId, conversationId: conversationId, handler: handler, ()))
        return retrySendingResult ?? CancellableMock()
    }

    var deleteMessageCallCount = 0
    var deleteMessageParams: [(messageId: UUID, conversationId: UUID, handler: (Result<Void, NablaError>) -> Void, Void)] = []
    var deleteMessageResult: Cancellable?
    func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        deleteMessageCallCount += 1
        deleteMessageParams.append((messageId: messageId, conversationId: conversationId, handler: handler, ()))
        return deleteMessageResult ?? CancellableMock()
    }
}

extension NablaMessagingClientProtocolMock {
    static var shared = NablaMessagingClientProtocolMock()
}
