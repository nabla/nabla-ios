import Foundation
import NablaUtils

/// Main entry-point for SDK messaging features.
public class NablaMessagingClient {
    // MARK: - Public
    
    public static let shared = NablaMessagingClient(client: .shared)

    /// Create a new conversation on behalf of the current user.
    /// - Parameter completion: Completion called when the ``Conversation`` is created or an ``Error`` if something went wrong.
    /// - Returns: A ``Cancellable`` of the task
    public func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        createConversationInteractor.execute(completion: completion)
    }

    /// Watch the list of messages in a conversation.
    /// The current user should be involved in that conversation or a security error will be raised.
    /// - Parameters:
    ///   - conversationId: The id of the conversation to watch.
    ///   - callback: The callback to call when new items are received.
    /// - Returns: A ``PaginatedWatcher`` of the task
    public func watchItems(ofConversationWithId conversationId: UUID, callback: @escaping (Result<ConversationItems, Error>) -> Void) -> PaginatedWatcher {
        watchConversationItemsInteractor.execute(conversationId: conversationId, callback: callback)
    }

    /// Change the current user typing status in the conversation.
    ///
    /// IMPORTANT: This is an ephemeral operation, if you want to keep your user marked as actively typing
    ///            you should call this with `isTyping = true` at least once every 20 seconds.
    ///
    /// Call with `isTyping = false` to immediately mark the user as not typing anymore.
    /// Typical use case is when the user deletes their draft.
    ///
    /// Please note that a successful call to `sendMessage` is enough to set typing to false,
    /// so calling both will simply be a redundancy.
    ///
    /// As this will always result in a network call, please avoid overuse. For instance, you don't want
    /// to call this each time the user types a new char, add a debounce instead.
    /// - Parameters:
    ///   - isTyping: A boolean declaring if the user is typing or not.
    ///   - conversationId: The id of the ``Conversation``.
    /// - Returns: A ``Cancellable`` of the task
    public func setIsTyping(_ isTyping: Bool, inConversationWithId conversationId: UUID) -> Cancellable {
        setIsTypingInteractor.execute(isTyping: isTyping, conversationId: conversationId)
    }

    /// Acknowledge that the current user has seen all messages in it.
    /// Will result in all messages sent before current timestamp to be marked as read.
    /// - Parameter conversationId: The id of the ``Conversation``
    /// - Returns: A ``Cancellable`` of the task
    public func markConversationAsSeen(_ conversationId: UUID) -> Cancellable {
        markConversationAsSeenInteractor.execute(conversationId: conversationId)
    }

    /// Watch the list of conversations the current user is involved in.
    /// - Parameter callback: The callback to call when new items are received.
    /// - Returns: A ``PaginatedWatcher`` of the task
    public func watchConversations(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        watchConversationsInteractor.execute(callback: callback)
    }
    
    public func watchConversation(
        _ conversationId: UUID,
        callback: @escaping (Result<Conversation, Error>) -> Void
    ) -> Cancellable {
        watchConversationInteractor.execute(conversationId, callback: callback)
    }

    /// Send a new message in the conversation referenced by its identifier.
    ///
    /// This will immediately append the message to the list of messages in the conversation
    /// while making the necessary network query (optimistic behavior).
    ///
    /// A successful sending will result in the message's status changing to ``ConversationItemState.sent``.
    /// While failures will change status to ``ConversationItemState.failed``.
    ///
    /// - Parameters:
    ///   - message: The message to send.
    ///   - conversationId: The id of the ``Conversation``
    ///   - completion: Completion called with the result when the message is sent.
    /// - Returns: A ``Cancellable`` of the task
    public func sendMessage(
        _ message: MessageInput,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        sendMessageInteractor.execute(message: message, conversationId: conversationId, completion: completion)
    }

    /// Retry sending a message for which `LocalConversationItem.state`` is ``ConversationItemState.failed``.
    /// - Parameters:
    ///   - itemId: The id of the message to send.
    ///   - conversationId: The id of the ``Conversation``
    ///   - completion: Completion called with the result when the message is sent.
    /// - Returns: A ``Cancellable`` of the task
    public func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        retrySendingMessageInteractor.execute(itemId: itemId, conversationId: conversationId, completion: completion)
    }

    /// Delete a message in the conversation. Current user should be its author.
    ///
    /// This will change the message type to ``DeletedMessageItem``.
    ///
    /// While this works for both messages that were successfully sent and those that failed sending,
    /// calling ``deleteMessage`` on a message being currently in status ``ConversationItemState.sending`` is very likely
    /// to have noop or unexpected behavior.
    /// - Parameters:
    ///   - messageId: The id of the message to delete.
    ///   - conversationId: The id of the ``Conversation``
    ///   - callback: Completion called with the result when the message is deleted.
    /// - Returns: A ``Cancellable`` of the task
    public func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        deleteMessageInteractor.execute(messageId: messageId, conversationId: conversationId, callback: callback)
    }
    
    public init(client _: NablaClient) {}
    
    // MARK: - Private
    
    @Inject private var createConversationInteractor: CreateConversationInteractor
    @Inject private var watchConversationItemsInteractor: WatchConversationItemsInteractor
    @Inject private var sendMessageInteractor: SendMessageInteractor
    @Inject private var retrySendingMessageInteractor: RetrySendingMessageInteractor
    @Inject private var deleteMessageInteractor: DeleteMessageInteractor
    @Inject private var setIsTypingInteractor: SetIsTypingInteractor
    @Inject private var markConversationAsSeenInteractor: MarkConversationAsSeenInteractor
    @Inject private var watchConversationsInteractor: WatchConversationsInteractor
    @Inject private var watchConversationInteractor: WatchConversationInteractor
}
