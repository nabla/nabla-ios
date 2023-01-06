import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationItemRemoteDataSource {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError>
    
    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<RemoteConversationEvent, Never>
    
    func send(
        remoteMessageInput: GQL.SendMessageInput,
        conversationId: UUID
    ) async throws
    
    func delete(messageId: UUID) async throws
}
