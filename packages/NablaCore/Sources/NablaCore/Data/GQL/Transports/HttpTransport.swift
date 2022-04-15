import Apollo
import Foundation
import NablaUtils

class HttpTransport {
    // MARK: - Internal
    
    private(set) lazy var apollo: UploadingNetworkTransport = makeApolloTransport()
    
    // MARK: - Private
    
    @Inject private var environment: Environment
    @Inject private var interceptorProvider: InterceptorProvider
    
    private func makeApolloTransport() -> UploadingNetworkTransport {
        RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider,
            endpointURL: environment.serverUrl.appendingPathComponent(environment.graphqlPath),
            additionalHeaders: [:],
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false
        )
    }
}
