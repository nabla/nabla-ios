import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
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
        let localConversationItem = makeLocalConversationItem(for: messageInput)
        localDataSource.addConversationItem(localConversationItem, toConversationWithId: conversationId)
        return makeRemoteMessageAndThenSend(
            localConversationItem: localConversationItem,
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

        if let item = localConversationItem as? LocalMediaConversationItem,
           case .media = item.content {
            return makeRemoteMessageAndThenSend(localConversationItem: localConversationItem, conversationId: conversationId, completion: completion)
        } else {
            return performSend(localConversationItem, inConversationWithId: conversationId, completion: completion)
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
    
    private func makeSendInput(for localConversationItem: LocalConversationItem) -> GQL.SendMessageContentInput? {
        if let textMessage = localConversationItem as? LocalTextMessageItem {
            return .init(textInput: .init(text: textMessage.content))
        }
        if let imageMessage = localConversationItem as? LocalImageMessageItem,
           case let .uploadedMedia(uploadedMedia) = imageMessage.content {
            return .init(imageInput: .init(upload: .init(uuid: uploadedMedia.fileUploadUUID)))
        }
        
        if let documentMessage = localConversationItem as? LocalDocumentMessageItem,
           case let .uploadedMedia(uploadedMedia) = documentMessage.content {
            return .init(documentInput: .init(upload: .init(uuid: uploadedMedia.fileUploadUUID)))
        }
        logger.warning(message: "Sending \(type(of: localConversationItem)) is not supported yet")
        return nil
    }

    private func makeLocalConversationItem(for input: MessageInput) -> LocalConversationItem {
        switch input {
        case let .text(content):
            return LocalTextMessageItem(clientId: UUID(), date: Date(), state: .sending, content: content)
        case let .image(content):
            return LocalImageMessageItem(clientId: UUID(), date: Date(), state: .sending, content: .media(content))
        case let .document(content):
            return LocalDocumentMessageItem(clientId: UUID(), date: Date(), state: .sending, content: .media(content))
        }
    }

    private func updateLocalConversationItem(
        _ localConversationItem: LocalConversationItem,
        with remoteMessageInput: RemoteMessageInput
    ) -> LocalConversationItem {
        switch remoteMessageInput {
        case let .text(content):
            return LocalTextMessageItem(
                clientId: localConversationItem.clientId,
                date: localConversationItem.date,
                state: .sending,
                content: content
            )
        case let .image(uploadedMedia):
            return LocalImageMessageItem(
                clientId: localConversationItem.clientId,
                date: localConversationItem.date,
                state: .sending,
                content: .uploadedMedia(uploadedMedia)
            )
        case let .document(uploadedDocument):
            return LocalDocumentMessageItem(
                clientId: localConversationItem.clientId,
                date: localConversationItem.date,
                state: .sending,
                content: .uploadedMedia(uploadedDocument)
            )
        }
    }

    private func makeRemoteMessageAndThenSend(
        localConversationItem: LocalConversationItem,
        conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> UmbrellaCancellable {
        let umbrellaCancellable = UmbrellaCancellable()
        makeRemoteMessageInput(from: localConversationItem) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(remoteMessage):
                guard !umbrellaCancellable.isCancelled else { return }
                let task = self.sendMessage(
                    remoteMessage,
                    existingLocalConversationItem: localConversationItem,
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
        existingLocalConversationItem localConversationItem: LocalConversationItem,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        let updatedLocalConversationItem = updateLocalConversationItem(localConversationItem, with: remoteMessage)
        localDataSource.updateConversationItem(updatedLocalConversationItem, inConversationWithId: conversationId)
        return performSend(updatedLocalConversationItem, inConversationWithId: conversationId, completion: completion)
    }

    private func performSend(
        _ localConversationItem: LocalConversationItem,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        guard let sendInput = makeSendInput(for: localConversationItem) else {
            return Failure()
        }
        return remoteDataSource.send(
            localMessageClientId: localConversationItem.clientId,
            remoteMessageInput: sendInput,
            conversationId: conversationId
        ) { [weak self] result in
            switch result {
            case let .failure(error):
                var copy = localConversationItem
                copy.state = .failed
                self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
                completion(.failure(error))
            case .success:
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
