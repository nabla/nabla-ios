import Foundation
import NablaUtils

public class NablaClient {
    // MARK: - Public

    public static var shared: NablaClient = initialize()

    public var apiKey: String?

    public func authenticate(
        userID: UUID,
        provider: NablaAuthenticationProvider,
        completion: (Result<Void, AuthenticationError>) -> Void
    ) {
        authenticator.authenticate(userID: userID, provider: provider, completion: completion)
    }

    public func logOut() {
        authenticator.logOut()
    }
    
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        gqlClient.addRefetchTriggers(triggers)
    }
    
    public func observeItems(ofConversationWithId conversationId: UUID, callback: @escaping (Result<ConversationItems, Error>) -> Void) -> Cancellable {
        observeConversationItemsInteractor.execute(conversationId: conversationId, callback: callback)
    }

    // MARK: - Private

    @Inject private var authenticator: Authenticator
    @Inject private var gqlClient: GQLClient
    @Inject private var getConversationListInteractor: GetConversationListInteractor
    @Inject private var observeConversationItemsInteractor: ObserveConversationItemsInteractor

    private static func initialize() -> NablaClient {
        let assembler = Assembler(assemblies: [
            AuthenticationAssembly(),
            DataSourceAssembly(),
            RepositoryAssembly(),
            InteractorAssembly(),
            HelperAssembly(),
            GQLAssembly(),
        ])
        assembler.assemble()
        return NablaClient()
    }
}
