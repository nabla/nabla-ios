import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationItemRemoteDataSource {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<AnyResponse<PaginatedList<RemoteConversationItem>, GQLError>, GQLError>
    
    func subscribeToConversationItemsEvents(
        ofConversationWithId conversationId: UUID
    ) -> AnyPublisher<RemoteConversationEvent, Never>
    
    func send(
        remoteMessageInput: GQL.SendMessageInput,
        conversationId: UUID
    ) async throws
    
    func delete(messageId: UUID) async throws
}
