import Foundation
import NablaUtils

class InteractorAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: CreateConversationInteractor.self) {
            CreateConversationInteractorImpl()
        }
        resolver.register(type: WatchConversationWithItemsInteractor.self) {
            WatchConversationWithItemsInteractorImpl()
        }
        resolver.register(type: WatchConversationListInteractor.self) {
            WatchConversationListInteractorImpl()
        }
        resolver.register(type: SendMessageInteractor.self) {
            SendMessageInteractorImpl()
        }
        resolver.register(type: SetIsTypingInteractor.self) {
            SetIsTypingInteractorImpl()
        }
    }
}
