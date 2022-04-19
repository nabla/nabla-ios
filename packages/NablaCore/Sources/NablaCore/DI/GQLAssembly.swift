import Apollo
import Foundation
import NablaUtils

class GQLAssembly: Assembly {
    // MARK: Assembly
    
    func assemble(resolver: Resolver) {
        resolver.register(type: GQLStore.self) {
            GQLStoreImpl()
        }
        
        resolver.register(type: InterceptorProvider.self) {
            HttpInterceptorProvider()
        }
        
        resolver.register(type: HttpTransport.self) {
            HttpTransport()
        }
        
        resolver.register(type: WebSocketTransport.self) {
            WebSocketTransport()
        }
        
        resolver.register(type: CombinedTransport.self) {
            CombinedTransport()
        }
        
        resolver.register(type: ReachabilityRefetchTrigger.self) {
            ReachabilityRefetchTrigger()
        }
        
        resolver.register(type: GQLClient.self) { resolver in
            let client = GQLClientImpl()
            let reachabilityRefetchTrigger = resolver.resolve(ReachabilityRefetchTrigger.self)
            client.addRefetchTriggers([reachabilityRefetchTrigger])
            return client
        }
    }
}
