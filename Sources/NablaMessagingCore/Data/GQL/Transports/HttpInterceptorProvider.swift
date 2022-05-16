import Apollo
import Foundation
import NablaUtils

class HttpInterceptorProvider: InterceptorProvider {
    // MARK: - Internal
    
    func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        var interceptors = defaultProvider.interceptors(for: operation)
        interceptors.insert(RequestHeadersInterceptor(), at: 0)
        interceptors.insert(AuthorizationInterceptor(), at: 0)
        return interceptors
    }
    
    // MARK: - Private
    
    @Inject private var apolloStore: ApolloStore
    
    private lazy var defaultProvider = DefaultInterceptorProvider(store: apolloStore)
}
