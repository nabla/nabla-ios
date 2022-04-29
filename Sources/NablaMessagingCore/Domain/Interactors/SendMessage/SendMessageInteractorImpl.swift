import Foundation
import NablaUtils

final class SendMessageInteractorImpl: SendMessageInteractor {
    func execute(message: MessageInput, conversationId: UUID, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        let umbrellaCancellable = UmbrellaCancellable()
        makeRemoteMessageInput(from: message) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(remoteMessage):
                guard !umbrellaCancellable.isCancelled else { return }
                let task = self.conversationItemRepository.sendMessage(remoteMessage, inConversationWithId: conversationId, completion: completion)
                umbrellaCancellable.add(task)
            case let .failure(error):
                completion(.failure(error))
            }
        }
        
        return umbrellaCancellable
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRepository: ConversationItemRepository
    @Inject private var fileUploadRemoteDataSource: FileUploadRemoteDataSource
    
    private func makeRemoteMessageInput(from message: MessageInput, completion: @escaping (Result<RemoteMessageInput, Error>) -> Void) {
        switch message {
        case let .text(content):
            completion(.success(.text(content)))
        case let .image(content):
            fileUploadRemoteDataSource.upload(media: content) { result in
                switch result {
                case let .success(uuid):
                    completion(.success(.image(.init(fileUploadUUID: uuid, media: content))))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        case let .document(content):
            fileUploadRemoteDataSource.upload(media: content) { result in
                switch result {
                case let .success(uuid):
                    completion(.success(.document(.init(fileUploadUUID: uuid, media: content))))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
