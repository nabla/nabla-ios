import Apollo
import Combine
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif
import Foundation

class CombinedTransport {
    // MARK: - Internal
    
    func observeConnectionState() -> AnyPublisher<EventsConnectionState, Never> {
        webSocketNetworkTransport
            .nabla.switchToLatest { webSocketNetworkTransport -> AnyPublisher<EventsConnectionState, Never> in
                if let webSocketNetworkTransport = webSocketNetworkTransport {
                    return webSocketNetworkTransport.observeConnectionState()
                } else {
                    return Just(.notConnected).eraseToAnyPublisher()
                }
            }
    }
    
    // MARK: Initializer
    
    init(
        userRepository: UserRepository,
        apolloStore: ApolloStore,
        environment: Environment,
        interceptorProvider: InterceptorProvider,
        authenticator: Authenticator,
        extraHeaders: ExtraHeaders,
        logger: Logger
    ) {
        self.userRepository = userRepository
        self.apolloStore = apolloStore
        self.environment = environment
        self.interceptorProvider = interceptorProvider
        self.authenticator = authenticator
        self.extraHeaders = extraHeaders
        self.logger = logger
        observeUser()
    }
    
    // MARK: - Private
    
    private let userRepository: UserRepository
    private let apolloStore: ApolloStore
    private let environment: Environment
    private let interceptorProvider: InterceptorProvider
    private let authenticator: Authenticator
    private let extraHeaders: ExtraHeaders
    private let logger: Logger
    
    private var userObserver: Combine.Cancellable?
    
    private let webSocketNetworkTransport = CurrentValueSubject<WebSocketTransport?, Never>(nil)
    
    private lazy var uploadingNetworkTransport: UploadingNetworkTransport = {
        RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider,
            endpointURL: environment.graphqlHttpUrl,
            additionalHeaders: [:],
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false
        )
    }()
    
    private func makeWebSocketNetworkTransport(user _: User) -> WebSocketTransport {
        WebSocketTransport(
            environment: environment,
            authenticator: authenticator,
            apolloStore: apolloStore,
            logger: logger,
            extraHeaders: extraHeaders
        )
    }
    
    private func observeUser() {
        userObserver = userRepository.watchCurrentUser()
            .sink(receiveValue: { [weak self] user in
                guard let self = self else { return }
                if let user = user {
                    self.webSocketNetworkTransport.send(self.makeWebSocketNetworkTransport(user: user))
                } else {
                    self.webSocketNetworkTransport.send(nil)
                }
            })
    }
}

/// The `CombinedTransport` reimplements the default `SplitNetworkTransport` but adds support for some mutable and nullable `WebSocketTransport`.
extension CombinedTransport: Apollo.NetworkTransport {
    public func send<Operation: GraphQLOperation>(
        operation: Operation,
        cachePolicy: CachePolicy,
        contextIdentifier: UUID? = nil,
        callbackQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) -> Apollo.Cancellable {
        if operation.operationType == .subscription {
            if let webSocketNetworkTransport = webSocketNetworkTransport.value {
                return webSocketNetworkTransport.apollo.send(
                    operation: operation,
                    cachePolicy: cachePolicy,
                    contextIdentifier: contextIdentifier,
                    callbackQueue: callbackQueue,
                    completionHandler: completionHandler
                )
            } else {
                let error = UserIdNotSetError()
                logger.error(message: "Trying to start subscription before authorizing a current user.", extra: ["error": error])
                completionHandler(.failure(error))
                return EmptyCancellable()
            }
        } else {
            return uploadingNetworkTransport.send(
                operation: operation,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                callbackQueue: callbackQueue,
                completionHandler: completionHandler
            )
        }
    }
}

extension CombinedTransport: UploadingNetworkTransport {
    func upload<Operation>(
        operation: Operation,
        files: [GraphQLFile],
        callbackQueue: DispatchQueue,
        completionHandler: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) -> Apollo.Cancellable where Operation: GraphQLOperation {
        uploadingNetworkTransport.upload(
            operation: operation,
            files: files,
            callbackQueue: callbackQueue,
            completionHandler: completionHandler
        )
    }
}
