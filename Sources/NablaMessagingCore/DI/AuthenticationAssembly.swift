import Foundation
import NablaUtils

class AuthenticationAssembly: Assembly {
    func assemble(resolver: Resolver) {
        resolver.register(type: Authenticator.self) {
            AuthenticatorImpl()
        }
    }
}
