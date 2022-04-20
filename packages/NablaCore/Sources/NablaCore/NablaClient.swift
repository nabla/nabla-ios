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
    
    public static func initialize(configuration: Configuration? = nil) {
        guard _shared == nil else {
            assertionFailure("NablaClient.initialize(configuration:) can only be called once")
            return
        }
        assemble(configuration: configuration ?? DefaultConfiguration())
        _shared = NablaClient()
    }

    public func authenticate(
        userID: UUID,
        provider: NablaAuthenticationProvider,
        completion: @escaping (Result<Void, AuthenticationError>) -> Void
    ) {
        authenticator.authenticate(userID: userID, provider: provider, completion: completion)
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
    
    public func observeItems(ofConversationWithId conversationId: UUID, callback: @escaping (Result<ConversationItems, Error>) -> Void) -> Cancellable {
        observeConversationItemsInteractor.execute(conversationId: conversationId, callback: callback)
    }

    public func watchConversationList(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        watchConversationListInteractor.execute(callback: callback)
    }

    public func sendMessage(
        _ message: MessageInput,
        inConversationWithId conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        sendMessageInteractor.execute(message: message, conversationId: conversationId, callback: callback)
    }

    // MARK: - Private

    @Inject private var authenticator: Authenticator
    @Inject private var gqlClient: GQLClient
    @Inject private var createConversationInteractor: CreateConversationInteractor
    @Inject private var getConversationListInteractor: GetConversationListInteractor
    @Inject private var observeConversationItemsInteractor: ObserveConversationItemsInteractor
    @Inject private var sendMessageInteractor: SendMessageInteractor
    @Inject private var watchConversationListInteractor: WatchConversationListInteractor
    
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
}
