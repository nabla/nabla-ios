import Foundation
import NablaUtils

public class NablaClient {
    // MARK: - Public
    
    public static var shared: NablaClient {
        guard let shared = _shared else {
            fatalError("NablaClient.initialize(configuration:) must be called before accessing NablaClient.shared")
        }
        return shared
    }
    
    public static func initialize(apiKey: String, configuration: Configuration? = nil) {
        guard _shared == nil else {
            assertionFailure("NablaClient.initialize(configuration:) can only be called once")
            return
        }
        HTTPHeaders.extra[HTTPHeaders.NablaApiKey] = formatApiKey(apiKey)
        assemble(configuration: configuration ?? DefaultConfiguration())
        _shared = NablaClient()
    }
    
    public func authenticate(
        provider: SessionTokenProvider,
        completion: @escaping (Result<Void, AuthenticationError>) -> Void
    ) {
        authenticator.authenticate(provider: provider, completion: completion)
    }
    
    public func logOut() {
        authenticator.logOut()
    }
    
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        gqlClient.addRefetchTriggers(triggers)
    }
    
    public func addHTTPHeader(name: String, value: String) {
        HTTPHeaders.extra[name] = value
    }
    
    public func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        createConversationInteractor.execute(completion: completion)
    }
    
    public func watchItems(ofConversationWithId conversationId: UUID, callback: @escaping (Result<ConversationItems, Error>) -> Void) -> PaginatedWatcher {
        watchConversationItemsInteractor.execute(conversationId: conversationId, callback: callback)
    }
    
    public func setIsTyping(_ isTyping: Bool, inConversationWithId conversationId: UUID) -> Cancellable {
        setIsTypingInteractor.execute(isTyping: isTyping, conversationId: conversationId)
    }
    
    public func markConversationAsSeen(_ conversationId: UUID) -> Cancellable {
        markConversationAsSeenInteractor.execute(conversationId: conversationId)
    }
    
    public func watchConversations(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        watchConversationsInteractor.execute(callback: callback)
    }
    
    public func watchConversation(
        _ conversationId: UUID,
        callback: @escaping (Result<Conversation, Error>) -> Void
    ) -> Cancellable {
        watchConversationInteractor.execute(conversationId, callback: callback)
    }
    
    public func sendMessage(
        _ message: MessageInput,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        sendMessageInteractor.execute(message: message, conversationId: conversationId, completion: completion)
    }
    
    public func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        retrySendingMessageInteractor.execute(itemId: itemId, conversationId: conversationId, completion: completion)
    }
    
    public func deleteMessage(
        withId messageId: UUID,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        deleteMessageInteractor.execute(messageId: messageId, conversationId: conversationId, callback: callback)
    }
    
    // MARK: - Private
    
    @Inject private var authenticator: Authenticator
    @Inject private var gqlClient: GQLClient
    @Inject private var createConversationInteractor: CreateConversationInteractor
    @Inject private var watchConversationItemsInteractor: WatchConversationItemsInteractor
    @Inject private var sendMessageInteractor: SendMessageInteractor
    @Inject private var retrySendingMessageInteractor: RetrySendingMessageInteractor
    @Inject private var deleteMessageInteractor: DeleteMessageInteractor
    @Inject private var setIsTypingInteractor: SetIsTypingInteractor
    @Inject private var markConversationAsSeenInteractor: MarkConversationAsSeenInteractor
    @Inject private var watchConversationsInteractor: WatchConversationsInteractor
    @Inject private var watchConversationInteractor: WatchConversationInteractor
    
    private static var _shared: NablaClient?
    
    private static func assemble(configuration: Configuration = DefaultConfiguration()) {
        let assembler = Assembler(assemblies: [
            AuthenticationAssembly(),
            DataSourceAssembly(),
            RepositoryAssembly(),
            InteractorAssembly(),
            HelperAssembly(configuration: configuration),
            NetworkAssembly(),
            GQLAssembly(),
        ])
        assembler.assemble()
    }
    
    private static func formatApiKey(_ apiKey: String) -> String {
        apiKey.replacingOccurrences(of: "Authorization: Bearer ", with: "")
    }
}
