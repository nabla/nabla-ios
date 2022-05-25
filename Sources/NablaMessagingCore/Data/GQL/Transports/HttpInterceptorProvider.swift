import Apollo
import Foundation

class HttpInterceptorProvider: InterceptorProvider {
    // MARK: - Initializer

    init(
        authenticator: Authenticator,
        apolloStore: ApolloStore,
        urlSessionClient: URLSessionClient
    ) {
        self.authenticator = authenticator
        defaultProvider = DefaultInterceptorProvider(client: urlSessionClient, store: apolloStore)
    }

    // MARK: - Internal
    
    func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        var interceptors = defaultProvider.interceptors(for: operation)
        interceptors.insert(RequestHeadersInterceptor(extraHeaders: extraHeaders), at: 0)
        interceptors.insert(AuthorizationInterceptor(authenticator: authenticator), at: 0)
        return interceptors
    }

    func addExtraHeader(key: String, value: String) {
        extraHeaders[key] = value
    }

    func removeExtraHeader(key: String, value _: String) {
        extraHeaders.removeValue(forKey: key)
    }
    
    // MARK: - Private

    private let authenticator: Authenticator

    private var extraHeaders: [String: String] = [:]
    
    private let defaultProvider: DefaultInterceptorProvider
}
