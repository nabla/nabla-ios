import Foundation
import NablaCore

class ConversationItemRepositoryImpl: ConversationItemRepository {
    // MARK: - Initializer
    
    init(
        itemsRemoteDataSource: ConversationItemRemoteDataSource,
        itemsLocalDataSource: ConversationItemLocalDataSource,
        fileUploadRemoteDataSource: FileUploadRemoteDataSource,
        conversationLocalDataSource: ConversationLocalDataSource,
        conversationRemoteDataSource: ConversationRemoteDataSource,
        logger: Logger
    ) {
        self.itemsRemoteDataSource = itemsRemoteDataSource
        self.itemsLocalDataSource = itemsLocalDataSource
        self.fileUploadRemoteDataSource = fileUploadRemoteDataSource
        self.conversationLocalDataSource = conversationLocalDataSource
        self.conversationRemoteDataSource = conversationRemoteDataSource
        self.logger = logger
    }
    
    // MARK: - ConversationItemRepository
    
    func watchConversationItems(
        ofConversationWithId conversationId: TransientUUID,
        handler: ResultHandler<ConversationItems, NablaError>
    ) -> PaginatedWatcher {
        let merger = ConversationItemsMerger(
            conversationId: conversationId,
            remoteDataSource: itemsRemoteDataSource,
            localDataSource: itemsLocalDataSource,
            logger: logger,
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
        inConversationWithId conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        let localMessage = makeLocalConversationMessage(
            for: messageInput,
            replyToMessageId: replyToMessageId,
            inConversationWithId: conversationId.localId
        )
        itemsLocalDataSource.addConversationItem(localMessage)
        return makeRemoteMessageAndThenSend(
            localConversationMessage: localMessage,
            conversationId: conversationId,
            handler: handler
        )
    }
    
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard let localConversationMessage = itemsLocalDataSource.getConversationItem(
            withClientId: itemId
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
            if let remoteId = conversationId.remoteId {
                return performSend(
                    localConversationMessage,
                    inConversationWithId: remoteId,
                    handler: handler
                )
            } else {
                return performCreateWithInitialMessage(
                    localConversationMessage,
                    inConversationWithId: conversationId,
                    handler: handler
                )
            }
        }
    }
    
    func deleteMessage(
        withId messageId: UUID,
        conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        itemsLocalDataSource.removeConversationItem(withClientId: messageId)
        
        guard conversationId.remoteId != nil else { return Failure() }
        return itemsRemoteDataSource.delete(
            messageId: messageId,
            handler: handler.pullbackError(GQLErrorTransformer.transform)
        )
    }
    
    // MARK: - Private
    
    private let itemsRemoteDataSource: ConversationItemRemoteDataSource
    private let itemsLocalDataSource: ConversationItemLocalDataSource
    private let fileUploadRemoteDataSource: FileUploadRemoteDataSource
    private let conversationLocalDataSource: ConversationLocalDataSource
    private let conversationRemoteDataSource: ConversationRemoteDataSource
    private let logger: Logger
    
    private var conversationEventsSubscriptions = [UUID: Weak<ConversationItemsSubscriber>]()
    private var conversationsBeingCreated = Set<UUID>()
    private var toBeSentMessageHandlers = [UUID: ResultHandler<Void, NablaError>]()
    private var postponedSendMessageActions = [Cancellable]()
    
    private func makeOrReuseConversationEventsSubscription(for conversationId: TransientUUID) -> Cancellable {
        // Always store and find subscriptions by `localId` because it immutable and non-null
        if let subscription = conversationEventsSubscriptions[conversationId.localId]?.value {
            return subscription
        }
        
        let subscription = ConversationItemsSubscriber(conversationId: conversationId, itemsRemoteDataSource: itemsRemoteDataSource, handler: .void)
        conversationEventsSubscriptions[conversationId.localId] = .init(value: subscription)
        return subscription
    }
    
    private func makeSendInput(for localConversationMessage: LocalConversationMessage) -> GQL.SendMessageInput? {
        if let textMessage = localConversationMessage as? LocalTextMessageItem {
            return .init(
                content: .init(textInput: .init(text: textMessage.content)),
                clientId: textMessage.clientId,
                replyToMessageId: textMessage.replyToUuid
            )
        }
        if let imageMessage = localConversationMessage as? LocalImageMessageItem {
            if let fileUploadUUID = imageMessage.content.uploadUuid {
                return .init(
                    content: .init(imageInput: .init(upload: .init(uuid: fileUploadUUID))),
                    clientId: imageMessage.clientId,
                    replyToMessageId: imageMessage.replyToUuid
                )
            } else {
                logger.error(message: "Sending an image requires an `uploadUuid`")
                return nil
            }
        }
        
        if let documentMessage = localConversationMessage as? LocalDocumentMessageItem {
            if let fileUploadUUID = documentMessage.content.uploadUuid {
                return .init(
                    content: .init(documentInput: .init(upload: .init(uuid: fileUploadUUID))),
                    clientId: documentMessage.clientId,
                    replyToMessageId: documentMessage.replyToUuid
                )
            } else {
                logger.error(message: "Sending a document requires an `uploadUuid`")
                return nil
            }
        }
        
        if let audioMessage = localConversationMessage as? LocalAudioMessageItem {
            if let fileUploadUUID = audioMessage.content.uploadUuid {
                return .init(
                    content: .init(audioInput: .init(upload: .init(uuid: fileUploadUUID))),
                    clientId: audioMessage.clientId,
                    replyToMessageId: audioMessage.replyToUuid
                )
            } else {
                logger.error(message: "Sending an audio file requires an `uploadUuid`")
                return nil
            }
        }
        
        if let videoMessage = localConversationMessage as? LocalVideoMessageItem {
            if let fileUploadUUID = videoMessage.content.uploadUuid {
                return .init(
                    content: .init(videoInput: .init(upload: .init(uuid: fileUploadUUID))),
                    clientId: videoMessage.clientId,
                    replyToMessageId: videoMessage.replyToUuid
                )
            } else {
                logger.error(message: "Sending a video file requires an `uploadUuid`")
                return nil
            }
        }
        
        logger.error(message: "Unsuported message input", extra: ["type": type(of: localConversationMessage)])
        return nil
    }
    
    private func makeLocalConversationMessage(
        for input: MessageInput,
        replyToMessageId: UUID?,
        inConversationWithId conversationId: UUID
    ) -> LocalConversationMessage {
        switch input {
        case let .text(content):
            return LocalTextMessageItem(
                conversationId: conversationId,
                clientId: UUID(),
                date: Date(),
                sendingState: .toBeSent,
                replyToUuid: replyToMessageId,
                content: content
            )
        case let .image(content):
            return LocalImageMessageItem(
                conversationId: conversationId,
                clientId: UUID(),
                date: Date(),
                sendingState: .toBeSent,
                replyToUuid: replyToMessageId,
                content: .init(media: content)
            )
        case let .video(content):
            return LocalVideoMessageItem(
                conversationId: conversationId,
                clientId: UUID(),
                date: Date(),
                sendingState: .toBeSent,
                replyToUuid: replyToMessageId,
                content: .init(media: content)
            )
        case let .document(content):
            return LocalDocumentMessageItem(
                conversationId: conversationId,
                clientId: UUID(),
                date: Date(),
                sendingState: .toBeSent,
                replyToUuid: replyToMessageId,
                content: .init(media: content)
            )
        case let .audio(content):
            return LocalAudioMessageItem(
                conversationId: conversationId,
                clientId: UUID(),
                date: Date(),
                sendingState: .toBeSent,
                replyToUuid: replyToMessageId,
                content: .init(media: content)
            )
        }
    }
    
    private func updateLocalConversationMessage(
        _ localConversationMessage: LocalConversationMessage,
        with remoteMessageInput: RemoteMessageInput
    ) -> LocalConversationMessage {
        switch remoteMessageInput {
        case let .text(content):
            return LocalTextMessageItem(
                conversationId: localConversationMessage.conversationId,
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: content
            )
        case let .image(uploadedImage):
            return LocalImageMessageItem(
                conversationId: localConversationMessage.conversationId,
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedImage.media, uploadUuid: uploadedImage.fileUploadUUID)
            )
        case let .video(uploadedVideo):
            return LocalVideoMessageItem(
                conversationId: localConversationMessage.conversationId,
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedVideo.media, uploadUuid: uploadedVideo.fileUploadUUID)
            )
        case let .document(uploadedDocument):
            return LocalDocumentMessageItem(
                conversationId: localConversationMessage.conversationId,
                clientId: localConversationMessage.clientId,
                date: localConversationMessage.date,
                sendingState: .toBeSent,
                replyToUuid: localConversationMessage.replyToUuid,
                content: .init(media: uploadedDocument.media, uploadUuid: uploadedDocument.fileUploadUUID)
            )
        case let .audio(uploadedAudio):
            return LocalAudioMessageItem(
                conversationId: localConversationMessage.conversationId,
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
        conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> UmbrellaCancellable {
        let umbrella = UmbrellaCancellable()
        let task = makeRemoteMessageInput(
            from: localConversationMessage,
            handler: .init { [weak self, weak umbrella] result in
                guard let self = self, let umbrella = umbrella, !umbrella.isCancelled else { return }
                
                switch result {
                case let .success(remoteMessage):
                    let task = self.sendMessage(
                        remoteMessage,
                        existingLocalConversationMessage: localConversationMessage,
                        inConversationWithId: conversationId,
                        handler: handler
                    )
                    umbrella.add(task)
                case let .failure(error):
                    var copy = localConversationMessage
                    copy.sendingState = .failed
                    self.itemsLocalDataSource.updateConversationItem(copy)
                    handler(.failure(error))
                }
            }
        )
        umbrella.add(task)
        return umbrella
    }
    
    private func makeRemoteMessageInput(
        from localConversationItem: LocalConversationItem,
        handler: ResultHandler<RemoteMessageInput, NablaError>
    ) -> Cancellable {
        if let localTextItem = localConversationItem as? LocalTextMessageItem {
            handler(.success(.text(localTextItem.content)))
        } else if let localImageItem = localConversationItem as? LocalImageMessageItem {
            let media = localImageItem.content.media
            return fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .image(.init(fileUploadUUID: $0, media: media)) }
            )
        } else if let localDocumentItem = localConversationItem as? LocalDocumentMessageItem {
            let media = localDocumentItem.content.media
            return fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .document(.init(fileUploadUUID: $0, media: media)) }
            )
        } else if let localAudioItem = localConversationItem as? LocalAudioMessageItem {
            let media = localAudioItem.content.media
            return fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .audio(.init(fileUploadUUID: $0, media: media)) }
            )
        } else if let localVideoItem = localConversationItem as? LocalVideoMessageItem {
            let media = localVideoItem.content.media
            return fileUploadRemoteDataSource.upload(
                file: transform(media),
                handler: handler
                    .pullbackError(Self.transformFileUploadError)
                    .pullback { .video(.init(fileUploadUUID: $0, media: media)) }
            )
        }
        
        logger.error(message: "Unknown local conversation item", extra: ["type": type(of: localConversationItem)])
        return Failure()
    }
    
    private func sendMessage(
        _ remoteMessage: RemoteMessageInput,
        existingLocalConversationMessage localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        let updatedLocalConversationMessage = updateLocalConversationMessage(localConversationMessage, with: remoteMessage)
        itemsLocalDataSource.updateConversationItem(updatedLocalConversationMessage)
        if let remoteId = conversationId.remoteId {
            return performSend(
                updatedLocalConversationMessage,
                inConversationWithId: remoteId,
                handler: handler
            )
        } else {
            return performCreateWithInitialMessage(
                updatedLocalConversationMessage,
                inConversationWithId: conversationId,
                handler: handler
            )
        }
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
        itemsLocalDataSource.updateConversationItem(copy)
        
        return itemsRemoteDataSource.send(
            remoteMessageInput: sendInput,
            conversationId: conversationId,
            handler: .init { [weak self] result in
                switch result {
                case let .failure(error):
                    var copy = localConversationMessage
                    copy.sendingState = .failed
                    self?.itemsLocalDataSource.updateConversationItem(copy)
                    
                    handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
                case .success:
                    var copy = localConversationMessage
                    copy.sendingState = .sent
                    self?.itemsLocalDataSource.updateConversationItem(copy)
                    
                    handler(.success(()))
                }
            }
        )
    }
    
    private func performCreateWithInitialMessage(
        _ localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard let sendInput = makeSendInput(for: localConversationMessage) else {
            handler(.failure(InvalidMessageError()))
            return Failure()
        }
        
        var copy = localConversationMessage
        if conversationsBeingCreated.contains(conversationId.localId) {
            // If conversation is being created, postpone sending the message until it's done.
            copy.sendingState = .toBeSent
            itemsLocalDataSource.updateConversationItem(copy)
            toBeSentMessageHandlers[copy.clientId] = handler
            return Success()
        } else if let remoteId = conversationId.remoteId {
            // Last minute check in case the conversation has been created since previous checks
            return performSend(localConversationMessage, inConversationWithId: remoteId, handler: handler)
        } else {
            conversationsBeingCreated.insert(conversationId.localId)
            copy.sendingState = .sending
            itemsLocalDataSource.updateConversationItem(copy)
        }
        
        let localConversation = conversationLocalDataSource.getConversation(withId: conversationId.localId)
        if localConversation == nil {
            logger.warning(message: "Will create a conversation with an initial message, but the corresponding local conversation was not found.")
        }
        
        return conversationRemoteDataSource
            .createConversation(
                title: localConversation?.title,
                providerIds: localConversation?.providerIds,
                initialMessage: sendInput,
                handler: .init { [weak self] result in
                    switch result {
                    case let .failure(error):
                        self?.conversationsBeingCreated.remove(conversationId.localId)
                        
                        self?.markDraftConversationPendingMessagesAsFailed(conversationId: conversationId)
                        
                        handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
                    case let .success(remoteConversation):
                        self?.conversationsBeingCreated.remove(conversationId.localId)
                        
                        var copy = localConversationMessage
                        copy.sendingState = .sent
                        self?.itemsLocalDataSource.updateConversationItem(copy)
                        
                        self?.updateLocalConversation(conversationId: conversationId, with: remoteConversation)
                        self?.sendDraftConversationPendingMessages(conversationId: conversationId)
                        
                        handler(.success(()))
                    }
                }
            )
    }
    
    private func updateLocalConversation(conversationId: TransientUUID, with remoteConversation: RemoteConversation) {
        conversationId.set(remoteId: remoteConversation.id)
        guard var localConversation = conversationLocalDataSource.getConversation(withId: conversationId.localId) else { return }
        localConversation.remoteId = remoteConversation.id
        conversationLocalDataSource.updateConversation(localConversation)
    }
    
    private func markDraftConversationPendingMessagesAsFailed(conversationId: TransientUUID) {
        let pendingItems = itemsLocalDataSource.getConversationItems(ofConversationWithId: conversationId.localId)
        var updatedItems = [LocalConversationItem]()
        for item in pendingItems {
            guard
                var messageItem = item as? LocalConversationMessage,
                messageItem.sendingState == .toBeSent || messageItem.sendingState == .sending
            else { continue }
            messageItem.sendingState = .failed
            updatedItems.append(messageItem)
        }
        itemsLocalDataSource.updateConversationItems(updatedItems)
    }
    
    private func sendDraftConversationPendingMessages(conversationId: TransientUUID) {
        guard let conversationRemoteId = conversationId.remoteId else {
            logger.error(message: "sendDraftConversationPendingMessages must be called after the conversation has been created.")
            return
        }
        let pendingItems = itemsLocalDataSource.getConversationItems(ofConversationWithId: conversationId.localId)
        for item in pendingItems {
            guard
                let messageItem = item as? LocalConversationMessage,
                messageItem.sendingState == .toBeSent || messageItem.sendingState == .failed
            else { continue }
            let handler = toBeSentMessageHandlers[item.clientId] ?? .void
            let action = performSend(messageItem, inConversationWithId: conversationRemoteId, handler: handler)
            postponedSendMessageActions.append(action)
        }
    }
    
    private static func transformFileUploadError(_ error: FileUploadRemoteDataSourceError) -> NablaError {
        switch error {
        case .cannotReadFileData:
            return CanNotReadFileDataError()
        case let .uploadError(error):
            return ServerError(underlyingError: error)
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
}

private struct Weak<T: AnyObject> {
    weak var value: T?
}

private class ConversationItemsSubscriber: Cancellable {
    func cancel() {
        subscription?.cancel()
        remoteIdObserver?.cancel()
    }
    
    init(
        conversationId: TransientUUID,
        itemsRemoteDataSource: ConversationItemRemoteDataSource,
        handler: ResultHandler<RemoteConversationEvent, GQLError>
    ) {
        self.conversationId = conversationId
        self.itemsRemoteDataSource = itemsRemoteDataSource
        self.handler = handler
        
        beginSubscription()
    }
    
    deinit {
        cancel()
    }
    
    private let conversationId: TransientUUID
    private let itemsRemoteDataSource: ConversationItemRemoteDataSource
    private let handler: ResultHandler<RemoteConversationEvent, GQLError>
    
    private var remoteIdObserver: Cancellable?
    private var subscription: Cancellable?
    
    private func beginSubscription() {
        if let remoteId = conversationId.remoteId {
            subscription = itemsRemoteDataSource.subscribeToConversationItemsEvents(ofConversationWithId: remoteId, handler: handler)
        } else {
            remoteIdObserver = conversationId.observeRemoteId { [weak self] remoteId in
                guard let self = self else { return }
                self.subscription = self.itemsRemoteDataSource.subscribeToConversationItemsEvents(ofConversationWithId: remoteId, handler: self.handler)
            }
        }
    }
}
