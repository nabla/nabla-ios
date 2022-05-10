import Foundation
import NablaUtils

class RepositoryAssembly: Assembly {
    // MARK: - Assembly
    
    func assemble(resolver: Resolver) {
        resolver.register(type: ConversationRepository.self) {
            ConversationRepositoryImpl()
        }
        resolver.register(type: ConversationItemRepository.self) {
            ConversationItemRepositoryImpl()
        }
        resolver.register(type: UserRepository.self) {
            UserRepositoryImpl()
        }
    }
}
