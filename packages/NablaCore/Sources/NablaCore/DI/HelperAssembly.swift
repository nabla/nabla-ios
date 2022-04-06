import Foundation
import NablaUtils

class HelperAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: URLCache.self) {
            URLCacheImplementation()
        }
        resolver.register(type: Environment.self) {
            EnvironmentImpl()
        }
    }
}
