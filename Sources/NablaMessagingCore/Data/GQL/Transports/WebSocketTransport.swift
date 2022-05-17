import Apollo
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif
import Foundation
import NablaUtils

#if canImport(ApolloWebSocket)
    typealias ApolloWebSocketTransport = ApolloWebSocket.WebSocketTransport
    typealias ApolloWebSocketTransportDelegate = ApolloWebSocket.WebSocketTransportDelegate
#else
    typealias ApolloWebSocketTransport = Apollo.WebSocketTransport
    typealias ApolloWebSocketTransportDelegate = Apollo.WebSocketTransportDelegate
#endif

class WebSocketTransport {
    // MARK: - Internal
    
    private(set) lazy var apollo: ApolloWebSocketTransport = makeApolloTransport()
    
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
    @Inject private var apolloStore: ApolloStore
    @Inject private var authenticator: Authenticator
    @Inject private var logger: Logger
    
    private func makeApolloTransport() -> ApolloWebSocketTransport {
        let apollo = ApolloWebSocketTransport(
            websocket: WebSocket(
                url: environment.graphqlWebSocketUrl,
                protocol: .graphql_ws
            ),
            store: apolloStore,
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
        authenticator.getAccessToken(
            handler: .init { [weak self] result in
                guard let self = self else {
                    return
                }
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
            })
    }
}

extension WebSocketTransport: ApolloWebSocketTransportDelegate {
    func webSocketTransportDidConnect(_: ApolloWebSocketTransport) {
        logger.info(message: "Websocket did connect")
    }
    
    func webSocketTransportDidReconnect(_: ApolloWebSocketTransport) {
        logger.info(message: "Websocket did reconnect")
    }
    
    func webSocketTransport(_: ApolloWebSocketTransport, didDisconnectWithError error: Error?) {
        logger.info(message: "Websocket did disconnect with error: \(error?.localizedDescription ?? "null")")
    }
}
