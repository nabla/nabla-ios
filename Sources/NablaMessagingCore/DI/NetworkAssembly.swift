import Foundation
import NablaUtils

private struct URLProvider: BaseURLProvider {
    let baseURL: URL
}

class NetworkAssembly: Assembly {
    func assemble(resolver: Resolver) {
        let environment = resolver.resolve(Environment.self)
        resolver.register(type: HTTPManager.self) {
            HTTPManager(
                baseURLProvider: URLProvider(
                    baseURL: environment.serverUrl
                )
            )
        }
        
        resolver.register(type: UploadClient.self) {
            UploadClient()
        }
    }
}
