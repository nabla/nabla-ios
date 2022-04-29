import Foundation
import NablaUtils

class HelperAssembly: Assembly {
    // MARK: - Assembly
    
    let configuration: Configuration
    
    init(
        configuration: Configuration
    ) {
        self.configuration = configuration
    }
    
    func assemble(resolver: Resolver) {
        resolver.register(type: URLCache.self) {
            URLCacheImplementation()
        }
        resolver.register(type: Environment.self) { [configuration] in
            EnvironmentImpl(configuration: configuration)
        }
        resolver.register(type: Logger.self, ConsoleLogger())
    }
}
