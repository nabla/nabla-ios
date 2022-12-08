import Combine
import Foundation
import NablaCore

/// Main entry-point for SDK messaging features.
public class NablaMessagingClient: NablaCore.MessagingClient {
    // MARK: - Public
    
    public static var shared: NablaMessagingClient {
        NablaClient.shared.messaging
    }
    
    public let container: MessagingContainer
    
    /// Create a new conversation on behalf of the current user.
    /// - Parameter withMessage: initial message to be sent in the conversation.
    /// - Parameter title: optional - title for the conversation
    /// - Parameter providerIds: optional - list providers ids that will participate in the conversation. Make sure the specified providers have enough rights to participate to a conversation. See [Roles and Permissions](https://docs.nabla.com/docs/roles-and-permissions).
    /// - Returns: The created ``Conversation``
    /// - Throws: ``NablaError``
    public func createConversation(
        withMessage message: MessageInput,
        title: String? = nil,
        providerIds: [UUID]? = nil
    ) async throws -> Conversation {
        try await Self.wrap { handler in
            container.createConversationInteractor.execute(
                message: message,
                title: title,
                providerIds: providerIds,
                handler: handler
            )
        }
    }
    
    /// Create a new conversation on the user's device. The conversation won't be sent to the server until at least one message is sent.
    /// - Parameter title: optional - title for the conversation
    /// - Parameter providerIds: optional - list providers ids that will participate in the conversation. Make sure the specified providers have enough rights to participate to a conversation. See [Roles and Permissions](https://docs.nabla.com/docs/roles-and-permissions).
    /// - Returns: The created ``Conversation``.
    public func startConversation(
        title: String? = nil,
        providerIds: [UUID]? = nil
    ) -> Conversation {
        container.startConversationInteractor.execute(
            title: title,
            providerIds: providerIds
        )
    }
    
    /// Watch the list of messages in a conversation.
    /// The current user should be involved in that conversation or a security error will be raised.
    /// - Parameters:
    ///   - conversationId: The id of the conversation to watch.
    /// - Returns: ``AnyPublisher<PaginatedList<ConversationItem>, NablaError>``
    public func watchItems(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError> {
        Self.wrap(
            method: { handler in
                container.watchConversationItemsInteractor.execute(conversationId: conversationId, handler: handler)
            },
            transform: { values, loadMore in
                PaginatedList(
                    elements: values.items,
                    loadMore: values.hasMore ? loadMore : nil
                )
            }
        )
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
    /// - Throws: ``NablaError``
    public func setIsTyping(
        _ isTyping: Bool,
        inConversationWithId conversationId: UUID
    ) async throws {
        try await container.setIsTypingInteractor.execute(isTyping: isTyping, conversationId: conversationId)
    }
    
    /// Acknowledge that the current user has seen all messages in it.
    /// Will result in all messages sent before current timestamp to be marked as read.
    /// - Parameter conversationId: The id of the ``Conversation``
    /// - Parameter handler: Handler called with the result.
    /// - Throws: ``NablaError``
    public func markConversationAsSeen(_ conversationId: UUID) async throws {
        try await container.markConversationAsSeenInteractor.execute(conversationId: conversationId)
    }
    
    /// Watch the list of conversations the current user is involved in.
    /// - Returns: ``AnyPublisher<PaginatedList<Conversation>, NablaError>``
    public func watchConversations() -> AnyPublisher<PaginatedList<Conversation>, NablaError> {
        Self.wrap(
            method: { handler in
                container.watchConversationsInteractor.execute(handler: handler)
            },
            transform: { values, loadMore in
                PaginatedList(
                    elements: values.conversations,
                    loadMore: values.hasMore ? loadMore : nil
                )
            }
        )
    }
    
    /// Watch a conversation details.
    /// - Parameters:
    ///   - conversationId: the id of the conversation you want to watch update for.
    /// - Returns: ``AnyPublisher<Conversation, NablaError>``
    public func watchConversation(
        withId conversationId: UUID
    ) -> AnyPublisher<Conversation, NablaError> {
        Self.wrap { handler in
            container.watchConversationInteractor.execute(conversationId, handler: handler)
        }
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
    /// - Throws: ``NablaError``
    public func sendMessage(
        _ message: MessageInput,
        replyingToMessageWithId replyToId: UUID?,
        inConversationWithId conversationId: UUID
    ) async throws {
        try await Self.wrap { handler in
            container.sendMessageInteractor.execute(
                message: message,
                replyToMessageId: replyToId,
                conversationId: conversationId,
                handler: handler
            )
        }
    }
    
    /// Retry sending a message for which `LocalConversationItem.state`` is ``ConversationItemState.failed``.
    /// - Parameters:
    ///   - itemId: The id of the message to send.
    ///   - conversationId: The id of the ``Conversation``
    /// - Throws: ``NablaError``
    public func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID
    ) async throws {
        try await Self.wrap { handler in
            container.retrySendingMessageInteractor.execute(
                itemId: itemId,
                conversationId: conversationId,
                handler: handler
            )
        }
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
    /// - Throws: ``NablaError``
    public func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID
    ) async throws {
        try await container.deleteMessageInteractor.execute(messageId: messageId, conversationId: conversationId)
    }
    
    /// Any ``RefetchTrigger`` will tell the SDK to update watchers with the latest server data.
    /// It is a common practice to add some ``NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)``
    /// in order to refresh the on screen information when your application comes back to foreground
    /// - Parameter triggers: The triggers to add.
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        container.gqlClient.addRefetchTriggers(triggers)
    }

    public convenience init(container: CoreContainer) {
        self.init(
            container: MessagingContainer(
                coreContainer: container
            )
        )
    }

    // MARK: - Internal
    
    init(
        container: MessagingContainer
    ) {
        self.container = container
        container.logOutInteractor.addAction {
            // TODO: Clear any user related data
        }
    }
    
    // MARK: - Private
    
    private static func makeLoadMore(from watcher: PaginatedWatcher?) -> () async throws -> Void {
        guard let watcher = watcher else { return {} }
        return {
            try await wrap { handler in
                watcher.loadMore(completion: handler.callAsFunction)
            }
        }
    }
    
    private static func wrap<Input, Output, Error: Swift.Error>(
        method: (ResultHandler<Input, Error>) -> PaginatedWatcher,
        transform: @escaping (Input, @escaping () async throws -> Void) -> Output
    ) -> AnyPublisher<Output, Error> {
        let subject = CurrentValueSubject<Output?, Error>(nil)
        
        var watcher: PaginatedWatcher?
        watcher = method(.init { result in
            switch result {
            case let .failure(error):
                subject.send(completion: .failure(error))
            case let .success(values):
                let loadMore = Self.makeLoadMore(from: watcher)
                let list = transform(values, loadMore)
                subject.send(list)
            }
        }
        )
        
        return subject
            .handleEvents(receiveCancel: {
                watcher?.cancel()
            })
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private static func wrap<Value, Error: Swift.Error>(
        method: (ResultHandler<Value, Error>) -> Watcher
    ) -> AnyPublisher<Value, Error> {
        let subject = CurrentValueSubject<Value?, Error>(nil)
        
        var watcher: Watcher?
        watcher = method(.init { result in
            switch result {
            case let .failure(error):
                subject.send(completion: .failure(error))
            case let .success(value):
                subject.send(value)
            }
        }
        )
        
        return subject
            .handleEvents(receiveCancel: {
                watcher?.cancel()
            })
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private static func wrap<Value, Error: Swift.Error>(method: (ResultHandler<Value, Error>) -> NablaCancellable) async throws -> Value {
        let holder = CancellableHolder()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Value, Swift.Error>) in
                    holder.value = method(.init(continuation.resume(with:)))
                }
            },
            onCancel: {
                holder.cancel()
            }
        )
    }
}

private class CancellableHolder: @unchecked Sendable {
    private var lock = NSRecursiveLock()
    private var innerCancellable: NablaCancellable?

    private func synced<Result>(_ action: () throws -> Result) rethrows -> Result {
        lock.lock()
        defer { lock.unlock() }
        return try action()
    }

    var value: NablaCancellable? {
        get { synced { innerCancellable } }
        set { synced { innerCancellable = newValue } }
    }

    func cancel() {
        synced { innerCancellable?.cancel() }
    }
    
    deinit {
        cancel()
    }
}
