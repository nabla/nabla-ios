import Apollo
import Foundation
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif

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
    
    init(
        environment: Environment,
        authenticator: Authenticator,
        apolloStore: ApolloStore,
        logger: Logger,
        extraHeaders: ExtraHeaders
    ) {
        self.environment = environment
        self.authenticator = authenticator
        self.logger = logger
        self.apolloStore = apolloStore
        self.extraHeaders = extraHeaders
        apollo.delegate = self
        self.authenticator.addObserver(self, selector: #selector(updateAuthenticationHeader))
        self.extraHeaders.addObserver(self, selector: #selector(updateStaticHeaders))
        updateStaticHeaders()
        updateAuthenticationHeader()
    }
    
    deinit {
        authenticator.removeObserver(self)
        extraHeaders.removeObserver(self)
    }
    
    // MARK: - Private

    private let environment: Environment
    private let apolloStore: ApolloStore
    private let authenticator: Authenticator
    private let logger: Logger
    private let extraHeaders: ExtraHeaders
    
    private func makeApolloTransport() -> ApolloWebSocketTransport {
        let apollo = ApolloWebSocketTransport(
            websocket: WebSocket(
                url: environment.graphqlWebSocketUrl,
                protocol: .graphql_ws
            ),
            store: apolloStore,
            clientName: environment.platform,
            clientVersion: environment.version,
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
        apollo.updateHeaderValues(extraHeaders.all, reconnectIfConnected: true)
    }
    
    @objc private func updateAuthenticationHeader() {
        Task {
            do {
                let state = try await authenticator.getAccessToken()
                switch state {
                case .notAuthenticated:
                    // We don't support any unauthenticated subscription
                    self.apollo.closeConnection()
                case let .authenticated(accessToken):
                    self.apollo.updateHeaderValues([HTTPHeaders.NablaAuthorization: "Bearer \(accessToken)"])
                    self.apollo.resumeWebSocketConnection(autoReconnect: true)
                }
            } catch {
                apollo.closeConnection()
            }
        }
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
        let extra: [String: Any]
        if let error = error {
            extra = ["error": error]
        } else {
            extra = [:]
        }
        logger.info(message: "Websocket did disconnect", extra: extra)
        if let error = error, isAuthError(error) {
            updateAuthenticationHeader()
        }
    }
    
    private func isAuthError(_ error: Error) -> Bool {
        guard
            let websocketError = error as? WebSocketError,
            let wsError = websocketError.error as? WebSocket.WSError
        else { return false }
        return wsError.code == 401
    }
}
