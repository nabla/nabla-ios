import Foundation
import NablaUtils

class InteractorAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: CreateConversationInteractor.self) {
            CreateConversationInteractorImpl()
        }
        resolver.register(type: GetConversationListInteractor.self) {
            GetConversationListInteractorImpl()
        }
        resolver.register(type: ObserveConversationItemsInteractor.self) {
            ObserveConversationItemsInteractorImpl()
        }
        resolver.register(type: WatchConversationListInteractor.self) {
            WatchConversationListInteractorImpl()
        }
        resolver.register(type: SendMessageInteractor.self) {
            SendMessageInteractorImpl()
        }
    }
}
