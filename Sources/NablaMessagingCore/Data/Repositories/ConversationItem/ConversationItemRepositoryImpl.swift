import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> PaginatedWatcher {
        let merger = ConversationItemsMerger(conversationId: conversationId, callback: callback)
        merger.resume()
        
        let holder = PaginatedWatcherAndSubscriptionHolder(watcher: merger)
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription(for: conversationId)
        holder.hold(eventsSubscription)
        
        return holder
    }
    
    func sendMessage(
        _ messageInput: MessageInput,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        let localConversationMessage = makeLocalConversationMessage(for: messageInput)
        localDataSource.addConversationItem(localConversationMessage, toConversationWithId: conversationId)
        return makeRemoteMessageAndThenSend(
            localConversationMessage: localConversationMessage,
            conversationId: conversationId,
            completion: completion
        )
    }

    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        guard let localConversationItem = localDataSource.getConversationItem(withClientId: itemId, inConversationWithId: conversationId) else {
            completion(.failure(ConversationItemRepositoryError.conversationItemNotFound))
            return Failure()
        }

        guard let localConversationMessage = localConversationItem as? LocalConversationMessage else {
            completion(.failure(ConversationItemRepositoryError.notSupported))
            return Failure()
        }
        
        if let mediaMessage = localConversationMessage as? LocalMediaConversationMessage,
           case .media = mediaMessage.content {
            return makeRemoteMessageAndThenSend(localConversationMessage: localConversationMessage, conversationId: conversationId, completion: completion)
        } else {
            return performSend(localConversationMessage, inConversationWithId: conversationId, completion: completion)
        }
    }
    
    func deleteMessage(withId messageId: UUID, conversationId _: UUID, callback: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        remoteDataSource.delete(messageId: messageId, callback: callback)
    }
    
    func setIsTyping(_ isTyping: Bool, conversationId: UUID) -> Cancellable {
        remoteDataSource.setIsTyping(isTyping, conversationId: conversationId)
    }
    
    func markConversationAsSeen(conversationId: UUID) -> Cancellable {
        remoteDataSource.markConversationAsSeen(conversationId: conversationId)
    }
    
    // MARK: - Private
    
    @Inject private var remoteDataSource: ConversationItemRemoteDataSource
    @Inject private var localDataSource: ConversationItemLocalDataSource
    @Inject private var fileUploadRemoteDataSource: FileUploadRemoteDataSource
    @Inject private var uploadClient: UploadClient
    @Inject private var logger: Logger
    private var conversationEventsSubscriptions = [UUID: WeakCancellable]()
    
    private func makeOrReuseConversationEventsSubscription(for conversationId: UUID) -> Cancellable {
        if let subscription = conversationEventsSubscriptions[conversationId]?.value {
            return subscription
        }
        
        let subscription = remoteDataSource.subscribeToConversationItemsEvents(ofConversationWithId: conversationId) { _ in }
        conversationEventsSubscriptions[conversationId] = WeakCancellable(value: subscription)
        return subscription
    }
    
    private func makeSendInput(for localConversationMessage: LocalConversationMessage) -> GQL.SendMessageContentInput? {
        if let textMessage = localConversationMessage as? LocalTextMessageItem {
            return .init(textInput: .init(text: textMessage.content))
        }
        if let imageMessage = localConversationMessage as? LocalImageMessageItem,
           case let .uploadedMedia(uploadedMedia) = imageMessage.content {
            return .init(imageInput: .init(upload: .init(uuid: uploadedMedia.fileUploadUUID)))
        }
        
        if let documentMessage = localConversationMessage as? LocalDocumentMessageItem,
           case let .uploadedMedia(uploadedMedia) = documentMessage.content {
            return .init(documentInput: .init(upload: .init(uuid: uploadedMedia.fileUploadUUID)))
        }
        logger.warning(message: "Sending \(type(of: localConversationMessage)) is not supported yet")
        return nil
    }
    
    private func makeLocalConversationMessage(for input: MessageInput) -> LocalConversationMessage {
        switch input {
        case let .text(content):
            return LocalTextMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, content: content)
        case let .image(content):
            return LocalImageMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, content: .media(content))
        case let .document(content):
            return LocalDocumentMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, content: .media(content))
        }
    }

    private func updateLocalConversationMessage(
        _ localConversationMessage: LocalConversationMessage,
        with remoteMessageInput: RemoteMessageInput
    ) -> LocalConversationMessage {
        switch remoteMessageInput {
        case let .text(content):
            return LocalTextMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                content: content
            )
        case let .image(uploadedMedia):
            return LocalImageMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                content: .uploadedMedia(uploadedMedia)
            )
        case let .document(uploadedDocument):
            return LocalDocumentMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                content: .uploadedMedia(uploadedDocument)
            )
        }
    }

    private func makeRemoteMessageAndThenSend(
        localConversationMessage: LocalConversationMessage,
        conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> UmbrellaCancellable {
        let umbrellaCancellable = UmbrellaCancellable()
        makeRemoteMessageInput(from: localConversationMessage) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(remoteMessage):
                guard !umbrellaCancellable.isCancelled else { return }
                let task = self.sendMessage(
                    remoteMessage,
                    existingLocalConversationMessage: localConversationMessage,
                    inConversationWithId: conversationId,
                    completion: completion
                )
                umbrellaCancellable.add(task)
            case let .failure(error):
                completion(.failure(error))
            }
        }
        return umbrellaCancellable
    }

    private func makeRemoteMessageInput(from localConversationItem: LocalConversationItem, completion: @escaping (Result<RemoteMessageInput, Error>) -> Void) {
        if let localTextItem = localConversationItem as? LocalTextMessageItem {
            completion(.success(.text(localTextItem.content)))
        } else if let localImageItem = localConversationItem as? LocalImageMessageItem {
            let media = localImageItem.content.media
            fileUploadRemoteDataSource.upload(file: transform(media)) { result in
                switch result {
                case let .success(uuid):
                    completion(.success(.image(.init(fileUploadUUID: uuid, media: media))))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } else if let localDocumentItem = localConversationItem as? LocalDocumentMessageItem {
            let media = localDocumentItem.content.media
            fileUploadRemoteDataSource.upload(file: transform(media)) { result in
                switch result {
                case let .success(uuid):
                    completion(.success(.document(.init(fileUploadUUID: uuid, media: media))))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } else {
            logger.warning(message: "Unknown local conversation item type: \(type(of: localConversationItem))")
        }
    }

    private func sendMessage(
        _ remoteMessage: RemoteMessageInput,
        existingLocalConversationMessage localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        let updatedLocalConversationMessage = updateLocalConversationMessage(localConversationMessage, with: remoteMessage)
        localDataSource.updateConversationItem(updatedLocalConversationMessage, inConversationWithId: conversationId)
        return performSend(updatedLocalConversationMessage, inConversationWithId: conversationId, completion: completion)
    }

    private func performSend(
        _ localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        guard let sendInput = makeSendInput(for: localConversationMessage) else {
            return Failure()
        }
        
        var copy = localConversationMessage
        copy.sendingState = .sending
        localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
        
        return remoteDataSource.send(
            localMessageClientId: localConversationMessage.clientId,
            remoteMessageInput: sendInput,
            conversationId: conversationId
        ) { [weak self] result in
            switch result {
            case let .failure(error):
                var copy = localConversationMessage
                copy.sendingState = .failed
                self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
                
                completion(.failure(error))
            case .success:
                var copy = localConversationMessage
                copy.sendingState = .sent
                self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
                
                completion(.success(()))
            }
        }
    }
}

private func transform(_ media: Media) -> RemoteFileUpload {
    .init(
        fileName: media.fileName,
        fileUrl: media.fileUrl,
        mimeType: media.mimeType,
        purpose: .message
    )
}

private struct WeakCancellable {
    weak var value: Cancellable?
}
