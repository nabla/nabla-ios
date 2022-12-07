import Foundation
import NablaCore

final class StartConversationInteractorImpl: StartConversationInteractor {
    // MARK: - Initializer

    init(repository: ConversationRepository) {
        self.repository = repository
    }

    // MARK: - Internal
    
    func execute(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation {
        repository.startConversation(
            title: title,
            providerIds: providerIds
        )
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
