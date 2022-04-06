import Apollo
import Foundation
import NablaUtils

class HttpInterceptorProvider: InterceptorProvider {
    // MARK: - Internal
    
    func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        let interceptors = defaultProvider.interceptors(for: operation)
        // TODO: @tgy add auth interceptor
        return interceptors
    }
    
    // MARK: - Private
    
    @Inject private var store: GQLStore
    
    private lazy var defaultProvider = DefaultInterceptorProvider(store: store.apollo)
}
