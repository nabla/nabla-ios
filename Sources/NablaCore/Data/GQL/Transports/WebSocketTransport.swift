import Apollo
import Combine
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
    
    func observeConnectionState() -> AnyPublisher<EventsConnectionState, Never> {
        connectionState
            .removeDuplicates(by: { lhs, rhs in
                switch (lhs, rhs) {
                case (.notConnected, .notConnected),
                     (.disconnected, .disconnected), // The `since` date is ignored, we always keep the first value
                     (.connecting, .connecting),
                     (.connected, .connected):
                    return true
                default:
                    return false
                }
            })
            .eraseToAnyPublisher()
    }
    
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
        self.extraHeaders.addObserver(self, selector: #selector(updateStaticHeaders))
        updateStaticHeaders()
        
        accessTokenObserver = authenticator.watchAuthenticationState()
            .sink { [weak self] authenticationState in
                self?.updateAuthenticationHeader(state: authenticationState)
            }
    }
    
    deinit {
        extraHeaders.removeObserver(self)
    }
    
    // MARK: - Private

    private let environment: Environment
    private let apolloStore: ApolloStore
    private let authenticator: Authenticator
    private let logger: Logger
    private let extraHeaders: ExtraHeaders
    
    private var connectionState = CurrentValueSubject<EventsConnectionState, Never>(.notConnected)
    private var accessTokenObserver: AnyCancellable?
    
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
    
    private func updateAuthenticationHeader(state: AuthenticationState) {
        switch state {
        case .notAuthenticated:
            // We don't support any unauthenticated subscription
            apollo.closeConnection()
            connectionState.send(.disconnected(since: Date()))
        case let .authenticated(accessToken):
            connectionState.send(.connecting)
            apollo.updateHeaderValues([HTTPHeaders.NablaAuthorization: "Bearer \(accessToken)"])
            apollo.resumeWebSocketConnection(autoReconnect: true)
        }
    }
}

extension WebSocketTransport: ApolloWebSocketTransportDelegate {
    func webSocketTransportDidConnect(_: ApolloWebSocketTransport) {
        connectionState.send(.connected)
        logger.info(message: "Websocket did connect")
    }
    
    func webSocketTransportDidReconnect(_: ApolloWebSocketTransport) {
        connectionState.send(.connected)
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
            logger.warning(message: "Websocket closing connection after authentication error", extra: extra)
            apollo.closeConnection()
            connectionState.send(.disconnected(since: Date()))
        } else {
            connectionState.send(.connecting)
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
