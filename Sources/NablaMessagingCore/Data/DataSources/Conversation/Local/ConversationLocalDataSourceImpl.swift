import Combine
import Foundation
import NablaCore

final class ConversationLocalDataSourceImpl: ConversationLocalDataSource {
    // MARK: - Internal
    
    func getConversation(withId id: UUID) -> LocalConversation? {
        conversations.value[id]
    }
    
    func startConversation(title: String?, providerIds: [UUID]?) -> LocalConversation {
        let conversation = LocalConversation(
            id: .init(),
            remoteId: nil,
            creationDate: .init(),
            title: title,
            providerIds: providerIds
        )
        conversations.value[conversation.id] = conversation
        return conversation
    }
    
    func updateConversation(
        _ conversation: LocalConversation
    ) {
        conversations.value[conversation.id] = conversation
    }
    
    func watchConversation(_ conversationId: UUID) -> AnyPublisher<LocalConversation?, Never> {
        conversations
            .map { $0[conversationId] }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let conversations = CurrentValueSubject<[UUID: LocalConversation], Never>([:])
}
