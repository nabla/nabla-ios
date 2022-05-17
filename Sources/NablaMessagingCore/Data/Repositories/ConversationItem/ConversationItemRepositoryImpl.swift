import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaWatchConversationItemsError>
    ) -> PaginatedWatcher {
        let merger = ConversationItemsMerger(
            conversationId: conversationId,
            handler: handler.pullbackError { .technicalError(.init(gqlError: $0)) }
        )
        merger.resume()
        
        let holder = PaginatedWatcherAndSubscriptionHolder(watcher: merger)
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription(for: conversationId)
        holder.hold(eventsSubscription)
        
        return holder
    }
    
    func sendMessage(
        _ messageInput: MessageInput,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> Cancellable {
        let localConversationMessage = makeLocalConversationMessage(for: messageInput)
        localDataSource.addConversationItem(localConversationMessage, toConversationWithId: conversationId)
        return makeRemoteMessageAndThenSend(
            localConversationMessage: localConversationMessage,
            conversationId: conversationId,
            handler: handler
        )
    }

    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaRetrySendingMessageError>
    ) -> Cancellable {
        guard let localConversationItem = localDataSource.getConversationItem(withClientId: itemId, inConversationWithId: conversationId) else {
            handler(.failure(.conversationItemNotFound))
            return Failure()
        }

        guard let localConversationMessage = localConversationItem as? LocalConversationMessage else {
            logger.error(message: "Cannot send a non-message item")
            handler(.failure(.invalidMessage))
            return Failure()
        }
        
        if let mediaMessage = localConversationMessage as? LocalMediaConversationMessage,
           case .media = mediaMessage.content {
            return makeRemoteMessageAndThenSend(
                localConversationMessage: localConversationMessage,
                conversationId: conversationId,
                handler: handler.pullbackError(Self.transformSendMessageError)
            )
        } else {
            return performSend(
                localConversationMessage,
                inConversationWithId: conversationId,
                handler: handler.pullbackError(Self.transformSendMessageError)
            )
        }
    }
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId _: UUID,
        handler: ResultHandler<Void, NablaDeleteMessageError>
    ) -> Cancellable {
        remoteDataSource.delete(
            messageId: messageId,
            handler: handler.pullbackError { .technicalError(.init(gqlError: $0)) }
        )
    }
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSetIsTypingError>
    ) -> Cancellable {
        remoteDataSource.setIsTyping(
            isTyping,
            conversationId: conversationId,
            handler: handler.pullbackError { .technicalError(.init(gqlError: $0)) }
        )
    }
    
    func markConversationAsSeen(conversationId: UUID, handler: ResultHandler<Void, NablaMarkConversationAsSeenError>) -> Cancellable {
        remoteDataSource.markConversationAsSeen(
            conversationId: conversationId,
            handler: handler.pullbackError { .technicalError(.init(gqlError: $0)) }
        )
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
        
        let subscription = remoteDataSource.subscribeToConversationItemsEvents(ofConversationWithId: conversationId, handler: .void)
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
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> UmbrellaCancellable {
        let umbrellaCancellable = UmbrellaCancellable()
        makeRemoteMessageInput(
            from: localConversationMessage,
            handler: .init { [weak self] result in
                guard let self = self else {
                    return
                }

                switch result {
                case let .success(remoteMessage):
                    guard !umbrellaCancellable.isCancelled else {
                        return
                    }
                    let task = self.sendMessage(
                        remoteMessage,
                        existingLocalConversationMessage: localConversationMessage,
                        inConversationWithId: conversationId,
                        handler: handler
                    )
                    umbrellaCancellable.add(task)
                case let .failure(error):
                    handler(.failure(error))
                }
            }
        )
        return umbrellaCancellable
    }

    private func makeRemoteMessageInput(
        from localConversationItem: LocalConversationItem,
        handler: ResultHandler<RemoteMessageInput, NablaSendMessageError>
    ) {
        if let localTextItem = localConversationItem as? LocalTextMessageItem {
            handler(.success(.text(localTextItem.content)))
        } else if let localImageItem = localConversationItem as? LocalImageMessageItem {
            let media = localImageItem.content.media
            fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .image(.init(fileUploadUUID: $0, media: media)) }
            )
        } else if let localDocumentItem = localConversationItem as? LocalDocumentMessageItem {
            let media = localDocumentItem.content.media
            fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .document(.init(fileUploadUUID: $0, media: media)) }
            )
        } else {
            logger.warning(message: "Unknown local conversation item type: \(type(of: localConversationItem))")
        }
    }

    private func sendMessage(
        _ remoteMessage: RemoteMessageInput,
        existingLocalConversationMessage localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> Cancellable {
        let updatedLocalConversationMessage = updateLocalConversationMessage(localConversationMessage, with: remoteMessage)
        localDataSource.updateConversationItem(updatedLocalConversationMessage, inConversationWithId: conversationId)
        return performSend(updatedLocalConversationMessage, inConversationWithId: conversationId, handler: handler)
    }

    private func performSend(
        _ localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> Cancellable {
        guard let sendInput = makeSendInput(for: localConversationMessage) else {
            handler(.failure(.notSupported))
            return Failure()
        }
        
        var copy = localConversationMessage
        copy.sendingState = .sending
        localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
        
        return remoteDataSource.send(
            localMessageClientId: localConversationMessage.clientId,
            remoteMessageInput: sendInput,
            conversationId: conversationId,
            handler: .init { [weak self] result in
                switch result {
                case let .failure(error):
                    var copy = localConversationMessage
                    copy.sendingState = .failed
                    self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)

                    handler(.failure(.technicalError(.init(gqlError: error))))
                case .success:
                    var copy = localConversationMessage
                    copy.sendingState = .sent
                    self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)

                    handler(.success(()))
                }
            }
        )
    }

    private static func transformFileUploadError(_ error: FileUploadRemoteDataSourceError) -> NablaSendMessageError {
        switch error {
        case .cannotReadFileData:
            return .cannotReadFileData
        case let .uploadError(error):
            return .uploadError(error)
        }
    }

    private static func transformSendMessageError(error: NablaSendMessageError) -> NablaRetrySendingMessageError {
        switch error {
        case .invalidMessage:
            return .invalidMessage
        case .notSupported:
            return .notSupported
        case .cannotReadFileData:
            return .cannotReadFileData
        case let .uploadError(error):
            return .uploadError(error)
        case let .technicalError(error):
            return .technicalError(error)
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
