import Apollo
import Foundation

class HttpTransport {
    // MARK: - Initializer

    init(
        environment: Environment,
        interceptorProvider: InterceptorProvider
    ) {
        self.environment = environment
        self.interceptorProvider = interceptorProvider
    }

    // MARK: - Internal
    
    private(set) lazy var apollo: UploadingNetworkTransport = makeApolloTransport()
    
    // MARK: - Private
    
    private let environment: Environment
    private let interceptorProvider: InterceptorProvider
    
    private func makeApolloTransport() -> UploadingNetworkTransport {
        RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider,
            endpointURL: environment.graphqlHttpUrl,
            additionalHeaders: [:],
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false
        )
    }
}
