import Apollo
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif
import Foundation
import NablaUtils

class CombinedTransport {
    // MARK: - Initializer

    init(
        httpTransport: HttpTransport,
        webSocketTransport: WebSocketTransport
    ) {
        self.httpTransport = httpTransport
        self.webSocketTransport = webSocketTransport
    }

    // MARK: - Internal
    
    private(set) lazy var apollo: NetworkTransport = makeApolloTransport()
    
    // MARK: - Private
    
    private let httpTransport: HttpTransport
    private let webSocketTransport: WebSocketTransport
    
    private func makeApolloTransport() -> NetworkTransport {
        SplitNetworkTransport(
            uploadingNetworkTransport: httpTransport.apollo,
            webSocketNetworkTransport: webSocketTransport.apollo
        )
    }
}
