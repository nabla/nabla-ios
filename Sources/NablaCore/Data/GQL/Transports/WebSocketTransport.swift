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
            logger.info(message: "Closing websocket connection due to missing authentication")
            apollo.closeConnection()
            connectionState.send(.disconnected(since: Date()))
        case let .authenticated(accessToken):
            apollo.updateHeaderValues([HTTPHeaders.NablaAuthorization: "Bearer \(accessToken)"], reconnectIfConnected: false)
            if apollo.isConnected() {
                logger.info(message: "Tokens changed but websocket is still connected.")
            } else {
                logger.info(message: "Resuming websocket with new tokens")
                apollo.resumeWebSocketConnection(autoReconnect: true)
                connectionState.send(.connecting)
            }
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
        if let error = error, error.isAuthenticationError {
            logger.warning(message: "Websocket closing connection after authentication error", extra: extra)
            authenticator.markTokensAsInvalid()
        } else {
            connectionState.send(.connecting)
        }
    }
}
