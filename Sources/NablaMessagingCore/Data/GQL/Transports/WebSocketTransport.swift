import Apollo
import ApolloWebSocket
import Foundation
import NablaUtils

class WebSocketTransport {
    // MARK: - Internal
    
    private(set) lazy var apollo: ApolloWebSocket.WebSocketTransport = makeApolloTransport()
    
    init() {
        apollo.delegate = self
        authenticator.addObserver(self, selector: #selector(updateAuthenticationHeader))
        HTTPHeaders.addObserver(self, selector: #selector(updateStaticHeaders), notification: .extraHeadersChanged)
        updateStaticHeaders()
        updateAuthenticationHeader()
    }
    
    deinit {
        authenticator.removeObserver(self)
    }
    
    // MARK: - Private
    
    @Inject private var environment: Environment
    @Inject private var store: GQLStore
    @Inject private var authenticator: Authenticator
    @Inject private var logger: Logger
    
    private func makeApolloTransport() -> ApolloWebSocket.WebSocketTransport {
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
        return apollo
    }
    
    @objc private func updateStaticHeaders() {
        apollo.updateHeaderValues(
            HTTPHeaders.extra,
            reconnectIfConnected: true
        )
    }
    
    @objc private func updateAuthenticationHeader() {
        authenticator.getAccessToken { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.apollo.closeConnection()
            case let .success(authenticationState):
                switch authenticationState {
                case .unauthenticated:
                    // We don't support any unauthenticated subscription
                    self.apollo.closeConnection()
                case let .authenticated(accessToken):
                    self.apollo.updateHeaderValues([HTTPHeaders.NablaAuthorization: "Bearer \(accessToken)"])
                    self.apollo.resumeWebSocketConnection(autoReconnect: true)
                }
            }
        }
    }
}

extension WebSocketTransport: ApolloWebSocket.WebSocketTransportDelegate {
    func webSocketTransportDidConnect(_: ApolloWebSocket.WebSocketTransport) {
        logger.info(message: "Websocket did connect")
    }
    
    func webSocketTransportDidReconnect(_: ApolloWebSocket.WebSocketTransport) {
        logger.info(message: "Websocket did reconnect")
    }
    
    func webSocketTransport(_: ApolloWebSocket.WebSocketTransport, didDisconnectWithError error: Error?) {
        logger.info(message: "Websocket did disconnect with error: \(error?.localizedDescription ?? "null")")
    }
}
