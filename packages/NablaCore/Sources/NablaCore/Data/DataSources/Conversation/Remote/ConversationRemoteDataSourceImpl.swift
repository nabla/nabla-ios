import Foundation
import NablaUtils

final class ConversationRemoteDataSourceImpl: ConversationRemoteDataSource {
    // MARK: - Internal
    
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        gqlClient.perform(mutation: GQL.CreateConversationMutation()) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(response):
                print(response)
                completion(.success(Conversation()))
            }
        }
    }
    
    // MARK: - Private
    
    @Inject private var gqlClient: GQLClient
}
