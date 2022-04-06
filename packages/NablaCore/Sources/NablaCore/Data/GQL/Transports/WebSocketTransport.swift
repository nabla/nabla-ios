import Apollo
import ApolloWebSocket
import Foundation
import NablaUtils

class WebSocketTransport {
    // MARK: - Internal
    
    private(set) lazy var apollo: NetworkTransport = makeApolloTransport()
    
    // MARK: - Private
    
    @Inject private var environment: Environment
    @Inject private var store: GQLStore
    
    private func makeApolloTransport() -> NetworkTransport {
        ApolloWebSocket.WebSocketTransport(
            websocket: WebSocket(
                url: environment.serverUrl,
                protocol: .graphql_transport_ws
            ),
            store: store.apollo,
            clientName: environment.packageName,
            clientVersion: environment.packageVersion,
            sendOperationIdentifiers: false,
            reconnect: true,
            reconnectionInterval: 1.0,
            allowSendingDuplicates: true,
            connectOnInit: false,
            connectingPayload: [:],
            requestBodyCreator: ApolloRequestBodyCreator(),
            operationMessageIdCreator: ApolloSequencedOperationMessageIdCreator()
        )
    }
}
