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
        resolver.register(type: WatchConversationsInteractor.self) {
            WatchConversationsInteractorImpl()
        }
        resolver.register(type: SendMessageInteractor.self) {
            SendMessageInteractorImpl()
        }
        resolver.register(type: RetrySendingMessageInteractor.self) {
            RetrySendingMessageInteractorImpl()
        }
        resolver.register(type: SetIsTypingInteractor.self) {
            SetIsTypingInteractorImpl()
        }
        resolver.register(type: DeleteMessageInteractor.self) {
            DeleteMessageInteractorImpl()
        }
        resolver.register(type: MarkConversationAsSeenInteractor.self) {
            MarkConversationAsSeenInteractorImpl()
        }
    }
}
