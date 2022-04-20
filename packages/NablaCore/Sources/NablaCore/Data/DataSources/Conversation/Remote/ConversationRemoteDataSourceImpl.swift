import Foundation
import NablaUtils

final class ConversationRemoteDataSourceImpl: ConversationRemoteDataSource {
    // MARK: - Internal
    
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        gqlClient.perform(mutation: GQL.CreateConversationMutation()) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                completion(.success(Self.transform(data: data)))
            }
        }
    }

    // MARK: - Private

    @Inject private var gqlClient: GQLClient

    private static func transform(data: GQL.CreateConversationMutation.Data) -> Conversation {
        Conversation(
            id: data.createConversation.conversation.id,
            avatarURL: nil,
            initials: nil,
            title: nil,
            lastMessagePreview: nil,
            lastUpdatedTime: Date(),
            isUnread: false
        )
    }
}
