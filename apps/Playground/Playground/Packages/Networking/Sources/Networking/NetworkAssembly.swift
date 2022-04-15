import Foundation
import NablaUtils

public class NetworkAssembly: Assembly {
    // MARK: - Public
    
    public init(
        baseUrl: URL,
        extraHeaders: [String: String]
    ) {
        self.baseUrl = baseUrl
        HTTPHeaders.extra = extraHeaders
    }
    
    public func assemble(resolver: Resolver) {
        resolver.register(type: HTTPManager.self) { [baseUrl] in
            HTTPManager(baseUrl: baseUrl)
        }
    }
    
    // MARK: - Private
    
    private let baseUrl: URL
}
