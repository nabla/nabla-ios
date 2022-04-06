import Foundation
import NablaUtils

class InteractorAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: GetConversationListInteractor.self) {
            GetConversationListInteractorImpl()
        }
    }
}