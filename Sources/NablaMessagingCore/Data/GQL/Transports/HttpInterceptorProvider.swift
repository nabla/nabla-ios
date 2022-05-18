import Apollo
import Foundation
import NablaUtils

class HttpInterceptorProvider: InterceptorProvider {
    // MARK: - Initializer

    init(
        httpManager: HTTPManager,
        authenticator: Authenticator,
        apolloStore: ApolloStore
    ) {
        self.httpManager = httpManager
        self.authenticator = authenticator
        self.apolloStore = apolloStore
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
    private let httpManager: HTTPManager
    private let apolloStore: ApolloStore

    private var extraHeaders: [String: String] = [:]
    
    private lazy var defaultProvider = DefaultInterceptorProvider(store: apolloStore)
}
