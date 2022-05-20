import Apollo
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif
import Foundation

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
        store: GQLStore,
        authenticator: Authenticator,
        apolloStore: ApolloStore,
        logger: Logger
    ) {
        self.environment = environment
        self.store = store
        self.authenticator = authenticator
        self.logger = logger
        self.apolloStore = apolloStore
        apollo.delegate = self
        self.authenticator.addObserver(self, selector: #selector(updateAuthenticationHeader))
        updateStaticHeaders()
        updateAuthenticationHeader()
    }

    func addExtraHeader(key: String, value: String) {
        extraHeaders[key] = value
        updateStaticHeaders()
    }

    func removeExtraHeader(key: String, value _: String) {
        extraHeaders.removeValue(forKey: key)
        updateStaticHeaders()
    }
    
    deinit {
        authenticator.removeObserver(self)
    }
    
    // MARK: - Private

    private let environment: Environment
    private let store: GQLStore
    private let apolloStore: ApolloStore
    private let authenticator: Authenticator
    private let logger: Logger

    private var extraHeaders: [String: String] = [:]
    
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
            extraHeaders,
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
                    case .notAuthenticated:
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
