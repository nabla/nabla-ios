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

    public func getConversations(block _: ([Int]) -> Void) {
        getConversationListInteractor.execute(conversationUuid: .init())
    }

    public func getMessages(conversationUUID _: UUID, block _: () -> [Int]) {}
    
    public func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        gqlClient.addRefetchTriggers(triggers)
    }

    // MARK: - Private

    @Inject private var authenticator: Authenticator
    @Inject private var getConversationListInteractor: GetConversationListInteractor
    @Inject private var gqlClient: GQLClient

    private static func initialize() -> NablaClient {
        let assembler = Assembler(assemblies: [
            AuthenticationAssembly(),
            RepositoryAssembly(),
            InteractorAssembly(),
            HelperAssembly(),
            GQLAssembly(),
        ])
        assembler.assemble()
        return NablaClient()
    }
}
