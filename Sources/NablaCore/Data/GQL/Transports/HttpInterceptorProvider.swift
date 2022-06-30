import Apollo
import Foundation

class HttpInterceptorProvider: InterceptorProvider {
    // MARK: - Initializer

    init(
        environment: Environment,
        authenticator: Authenticator,
        extraHeaders: ExtraHeaders,
        apolloStore: ApolloStore,
        urlSessionClient: URLSessionClient
    ) {
        self.environment = environment
        self.authenticator = authenticator
        self.extraHeaders = extraHeaders
        defaultProvider = DefaultInterceptorProvider(client: urlSessionClient, store: apolloStore)
    }

    // MARK: - Internal
    
    func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        var interceptors = defaultProvider.interceptors(for: operation)
        interceptors.insert(RequestHeadersInterceptor(environment: environment, extraHeaders: extraHeaders), at: 0)
        interceptors.insert(AuthorizationInterceptor(authenticator: authenticator), at: 0)
        return interceptors
    }
    
    // MARK: - Private

    private let environment: Environment
    private let authenticator: Authenticator
    private let extraHeaders: ExtraHeaders
    
    private let defaultProvider: DefaultInterceptorProvider
}
