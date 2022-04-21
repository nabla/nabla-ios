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
    @Inject private var authenticator: Authenticator
    
    private func makeApolloTransport() -> NetworkTransport {
        let apollo = ApolloWebSocket.WebSocketTransport(
            websocket: WebSocket(
                url: environment.graphqlWebSocketUrl,
                protocol: .graphql_ws
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
        
        apollo.updateHeaderValues(HTTPHeaders.extra)
        
        authenticator.getAccessToken { result in
            switch result {
            case .failure:
                apollo.closeConnection()
            case let .success(authenticationState):
                switch authenticationState {
                case .unauthenticated:
                    apollo.updateHeaderValues([HTTPHeaders.NablaAuthorization: nil])
                case let .authenticated(accessToken):
                    apollo.updateHeaderValues([HTTPHeaders.NablaAuthorization: "Bearer \(accessToken)"])
                }
                apollo.resumeWebSocketConnection(autoReconnect: true)
            }
        }
        apollo.delegate = self
        return apollo
    }
}

extension WebSocketTransport: ApolloWebSocket.WebSocketTransportDelegate {
    func webSocketTransportDidConnect(_: ApolloWebSocket.WebSocketTransport) {
        print("didConnect") // TODO: @tgy
    }
    
    func webSocketTransportDidReconnect(_: ApolloWebSocket.WebSocketTransport) {
        print("didReconnect") // TODO: @tgy
    }
    
    func webSocketTransport(_: ApolloWebSocket.WebSocketTransport, didDisconnectWithError error: Error?) {
        print("Disconnect \(error)") // TODO: @tgy
    }
}
