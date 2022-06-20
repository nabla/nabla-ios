import Foundation

protocol CreateConversationInteractor {
    func execute(
        title: String?,
        providerIdToAssign: UUID?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable
}
