import Apollo
import ApolloWebSocket
import Foundation
import NablaUtils

class CombinedTransport {
    // MARK: - Internal
    
    private(set) lazy var apollo: NetworkTransport = makeApolloTransport()
    
    // MARK: - Private

    @Inject private var httpTransport: HttpTransport
    @Inject private var webSocketTransport: WebSocketTransport
    
    private func makeApolloTransport() -> NetworkTransport {
        SplitNetworkTransport(
            uploadingNetworkTransport: httpTransport.apollo,
            webSocketNetworkTransport: webSocketTransport.apollo
        )
    }
}
