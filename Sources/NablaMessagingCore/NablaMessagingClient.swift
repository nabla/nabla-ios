import Foundation

/// Main entry-point for SDK messaging features.
public class NablaMessagingClient {
    // MARK: - Public
    
    public static let shared = NablaMessagingClient(client: .shared)

    public var logger: Logger {
        coreContainer.logger
    }

    /// Create a new conversation on behalf of the current user.
    /// - Parameter handler: Handler called when the ``Conversation`` is created or an ``Error`` if something went wrong.
    /// - Returns: A ``Cancellable`` of the task
    public func createConversation(handler: @escaping (Result<Conversation, NablaError>) -> Void) -> Cancellable {
        container.createConversationInteractor.execute(handler: .init(handler))
    }

    /// Watch the list of messages in a conversation.
    /// The current user should be involved in that conversation or a security error will be raised.
    /// - Parameters:
    ///   - conversationId: The id of the conversation to watch.
    ///   - handler: The handler to call when new items are received.
    /// - Returns: A ``PaginatedWatcher`` of the task
    public func watchItems(
        ofConversationWithId conversationId: UUID,
        handler: @escaping (Result<ConversationItems, NablaError>) -> Void
    ) -> PaginatedWatcher {
        container.watchConversationItemsInteractor.execute(conversationId: conversationId, handler: .init(handler))
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
    ///   - handler: Handler called with the result.
    /// - Returns: A ``Cancellable`` of the task
    public func setIsTyping(
        _ isTyping: Bool,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        container.setIsTypingInteractor.execute(isTyping: isTyping, conversationId: conversationId, handler: .init(handler))
    }

    /// Acknowledge that the current user has seen all messages in it.
    /// Will result in all messages sent before current timestamp to be marked as read.
    /// - Parameter conversationId: The id of the ``Conversation``
    /// - Parameter handler: Handler called with the result.
    /// - Returns: A ``Cancellable`` of the task
    public func markConversationAsSeen(
        _ conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        container.markConversationAsSeenInteractor.execute(conversationId: conversationId, handler: .init(handler))
    }

    /// Watch the list of conversations the current user is involved in.
    /// - Parameter handler: The callback to call when new items are received.
    /// - Returns: A ``PaginatedWatcher`` of the task
    public func watchConversations(handler: @escaping (Result<ConversationList, NablaError>) -> Void) -> PaginatedWatcher {
        container.watchConversationsInteractor.execute(handler: .init(handler))
    }

    /// Watch a conversation details.
    /// - Parameters:
    ///   - conversationId: the id of the conversation you want to watch update for.
    ///   - handler: Handler called every time something changes in the conversation state
    public func watchConversation(
        _ conversationId: UUID,
        handler: @escaping (Result<Conversation, NablaError>) -> Void
    ) -> Cancellable {
        container.watchConversationInteractor.execute(conversationId, handler: .init(handler))
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
    ///   - replyingToMessageWithId: Id of the message we reply to
    ///   - conversationId: The id of the ``Conversation``
    ///   - handler: Handler called with the result when the message is sent.
    /// - Returns: A ``Cancellable`` of the task
    public func sendMessage(
        _ message: MessageInput,
        replyingToMessageWithId replyToId: UUID?,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        container.sendMessageInteractor.execute(message: message, replyToMessageId: replyToId, conversationId: conversationId, handler: .init(handler))
    }

    /// Retry sending a message for which `LocalConversationItem.state`` is ``ConversationItemState.failed``.
    /// - Parameters:
    ///   - itemId: The id of the message to send.
    ///   - conversationId: The id of the ``Conversation``
    ///   - handler: Handler called with the result when the message is sent.
    /// - Returns: A ``Cancellable`` of the task
    public func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        container.retrySendingMessageInteractor.execute(itemId: itemId, conversationId: conversationId, handler: .init(handler))
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
    ///   - handler: Handler called with the result when the message is deleted.
    /// - Returns: A ``Cancellable`` of the task
    public func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        handler: @escaping (Result<Void, NablaError>) -> Void
    ) -> Cancellable {
        container.deleteMessageInteractor.execute(messageId: messageId, conversationId: conversationId, handler: .init(handler))
    }

    public init(client: NablaClient) {
        coreContainer = client.container
        container = MessagingContainer(coreContainer: client.container)
    }

    // MARK: - Internal

    private(set) var container: MessagingContainer

    // MARK: - Private

    private var coreContainer: CoreContainer
}
