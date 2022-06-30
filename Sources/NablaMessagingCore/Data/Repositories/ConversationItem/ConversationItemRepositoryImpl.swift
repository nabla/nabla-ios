import Foundation
import NablaCore

class ConversationItemRepositoryImpl: ConversationItemRepository {
    // MARK: - Initializer

    init(
        remoteDataSource: ConversationItemRemoteDataSource,
        localDataSource: ConversationItemLocalDataSource,
        fileUploadRemoteDataSource: FileUploadRemoteDataSource,
        uploadClient: UploadClient,
        logger: Logger
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.fileUploadRemoteDataSource = fileUploadRemoteDataSource
        self.uploadClient = uploadClient
        self.logger = logger
    }

    // MARK: - ConversationItemRepository

    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaError>
    ) -> PaginatedWatcher {
        let merger = ConversationItemsMerger(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
            conversationId: conversationId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
        merger.resume()
        
        let holder = PaginatedWatcherAndSubscriptionHolder(watcher: merger)
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription(for: conversationId)
        holder.hold(eventsSubscription)
        
        return holder
    }
    
    func sendMessage(
        _ messageInput: MessageInput,
        replyToMessageId: UUID?,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        let umbrellaCancellable = UmbrellaCancellable()
        let task = makeLocalConversationMessage(
            for: messageInput,
            replyToMessageId: replyToMessageId,
            conversationId: conversationId,
            handler: .init { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(localMessage):
                    self.localDataSource.addConversationItem(localMessage, toConversationWithId: conversationId)
                    let task = self.makeRemoteMessageAndThenSend(
                        localConversationMessage: localMessage,
                        conversationId: conversationId,
                        handler: handler
                    )
                    umbrellaCancellable.add(task)
                case let .failure(error):
                    handler(.failure(error))
                }
            }
        )
        umbrellaCancellable.add(task)

        return umbrellaCancellable
    }

    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard let localConversationMessage = localDataSource.getConversationItem(
            withClientId: itemId,
            inConversationWithId: conversationId
        ) as? LocalConversationMessage else {
            handler(.failure(MessageNotFoundError()))
            return Failure()
        }

        if let mediaMessage = localConversationMessage as? LocalMediaConversationMessage,
           !mediaMessage.isUploaded {
            return makeRemoteMessageAndThenSend(
                localConversationMessage: localConversationMessage,
                conversationId: conversationId,
                handler: handler
            )
        } else {
            return performSend(
                localConversationMessage,
                inConversationWithId: conversationId,
                handler: handler
            )
        }
    }
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId _: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        remoteDataSource.delete(
            messageId: messageId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
    }
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        remoteDataSource.setIsTyping(
            isTyping,
            conversationId: conversationId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
    }
    
    func markConversationAsSeen(conversationId: UUID, handler: ResultHandler<Void, NablaError>) -> Cancellable {
        remoteDataSource.markConversationAsSeen(
            conversationId: conversationId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
    }
    
    // MARK: - Private
    
    private let remoteDataSource: ConversationItemRemoteDataSource
    private let localDataSource: ConversationItemLocalDataSource
    private let fileUploadRemoteDataSource: FileUploadRemoteDataSource
    private let uploadClient: UploadClient
    private let logger: Logger

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
           let fileUploadUUID = imageMessage.content.uploadUuid {
            return .init(imageInput: .init(upload: .init(uuid: fileUploadUUID)))
        }
        
        if let documentMessage = localConversationMessage as? LocalDocumentMessageItem,
           let fileUploadUUID = documentMessage.content.uploadUuid {
            return .init(documentInput: .init(upload: .init(uuid: fileUploadUUID)))
        }

        if let audioMessage = localConversationMessage as? LocalAudioMessageItem,
           let fileUploadUUID = audioMessage.content.uploadUuid {
            return .init(audioInput: .init(upload: .init(uuid: fileUploadUUID)))
        }

        if let videoMessage = localConversationMessage as? LocalVideoMessageItem,
           let fileUploadUUID = videoMessage.content.uploadUuid {
            return .init(videoInput: .init(upload: .init(uuid: fileUploadUUID)))
        }
        
        logger.error(message: "Unsuported message input", extra: ["type": type(of: localConversationMessage)])
        return nil
    }

    private func makeLocalConversationMessage(
        for input: MessageInput,
        replyToMessageId: UUID?,
        conversationId: UUID,
        handler: ResultHandler<LocalConversationMessage, NablaError>
    ) -> Cancellable {
        remoteDataSource.getConversationItems(
            ofConversationWithId: conversationId,
            handler: handler
                .pullbackError(GQLErrorTransformer.transform)
                .pullback(
                    { _ in
                        switch input {
                        case let .text(content):
                            return LocalTextMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, replyToUuid: replyToMessageId, content: content)
                        case let .image(content):
                            return LocalImageMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, replyToUuid: replyToMessageId, content: .init(media: content))
                        case let .video(content):
                            return LocalVideoMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, replyToUuid: replyToMessageId, content: .init(media: content))
                        case let .document(content):
                            return LocalDocumentMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, replyToUuid: replyToMessageId, content: .init(media: content))
                        case let .audio(content):
                            return LocalAudioMessageItem(clientId: UUID(), date: Date(), sendingState: .toBeSent, replyToUuid: replyToMessageId, content: .init(media: content))
                        }
                    }
                )
        )
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
                replyToUuid: localConversationMessage.replyToUuid,
                content: content
            )
        case let .image(uploadedImage):
            return LocalImageMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedImage.media, uploadUuid: uploadedImage.fileUploadUUID)
            )
        case let .video(uploadedVideo):
            return LocalVideoMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedVideo.media, uploadUuid: uploadedVideo.fileUploadUUID)
            )
        case let .document(uploadedDocument):
            return LocalDocumentMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedDocument.media, uploadUuid: uploadedDocument.fileUploadUUID)
            )
        case let .audio(uploadedAudio):
            return LocalAudioMessageItem(
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedAudio.media, uploadUuid: uploadedAudio.fileUploadUUID)
            )
        }
    }

    private func makeRemoteMessageAndThenSend(
        localConversationMessage: LocalConversationMessage,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
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
        handler: ResultHandler<RemoteMessageInput, NablaError>
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
        } else if let localAudioItem = localConversationItem as? LocalAudioMessageItem {
            let media = localAudioItem.content.media
            fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .audio(.init(fileUploadUUID: $0, media: media)) }
            )
        } else if let localVideoItem = localConversationItem as? LocalVideoMessageItem {
            let media = localVideoItem.content.media
            fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .video(.init(fileUploadUUID: $0, media: media)) }
            )
        } else {
            logger.error(message: "Unknown local conversation item", extra: ["type": type(of: localConversationItem)])
        }
    }

    private func sendMessage(
        _ remoteMessage: RemoteMessageInput,
        existingLocalConversationMessage localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        let updatedLocalConversationMessage = updateLocalConversationMessage(localConversationMessage, with: remoteMessage)
        localDataSource.updateConversationItem(updatedLocalConversationMessage, inConversationWithId: conversationId)
        return performSend(updatedLocalConversationMessage, inConversationWithId: conversationId, handler: handler)
    }

    private func performSend(
        _ localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard let sendInput = makeSendInput(for: localConversationMessage) else {
            handler(.failure(InvalidMessageError()))
            return Failure()
        }
        
        var copy = localConversationMessage
        copy.sendingState = .sending
        localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
        
        return remoteDataSource.send(
            localMessageClientId: localConversationMessage.clientId,
            remoteMessageInput: sendInput,
            conversationId: conversationId,
            replyToMessageId: localConversationMessage.replyToUuid,
            handler: .init { [weak self] result in
                switch result {
                case let .failure(error):
                    var copy = localConversationMessage
                    copy.sendingState = .failed
                    self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)

                    handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
                case .success:
                    var copy = localConversationMessage
                    copy.sendingState = .sent
                    self?.localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)

                    handler(.success(()))
                }
            }
        )
    }

    private static func transformFileUploadError(_ error: FileUploadRemoteDataSourceError) -> NablaError {
        switch error {
        case .cannotReadFileData:
            return CanNotReadFileDataError()
        case let .uploadError(error):
            return ServerError(underlyingError: error)
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
