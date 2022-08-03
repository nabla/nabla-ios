import Foundation
import NablaCore

final class CreateDraftConversationInteractorImpl: CreateDraftConversationInteractor {
    // MARK: - Initializer

    init(repository: ConversationRepository) {
        self.repository = repository
    }

    // MARK: - Internal
    
    func execute(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation {
        repository.createDraftConversation(title: title, providerIds: providerIds)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
