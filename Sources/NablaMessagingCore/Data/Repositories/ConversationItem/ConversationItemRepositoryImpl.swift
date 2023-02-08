import Combine
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
        ofConversationWithId conversationId: TransientUUID
    ) -> AnyPublisher<AnyResponse<PaginatedList<ConversationItem>, NablaError>, NablaError> {
        let localData = itemsLocalDataSource
            .watchConversationItems(ofConversationWithId: conversationId.localId)
            .setFailureType(to: NablaError.self)
            .eraseToAnyPublisher()
        
        let remoteData = conversationId.observeRemoteId()
            .map { [itemsRemoteDataSource] remoteConversationId -> AnyPublisher<AnyResponse<PaginatedList<RemoteConversationItem>, NablaError>, NablaError> in
                if let remoteConversationId = remoteConversationId {
                    return itemsRemoteDataSource
                        .watchConversationItems(ofConversationWithId: remoteConversationId)
                        .mapError(GQLErrorTransformer.transform(gqlError:))
                        .map { response in
                            response.mapError(GQLErrorTransformer.transform(gqlError:))
                        }
                        .eraseToAnyPublisher()
                } else {
                    let initialValue = AnyResponse<PaginatedList<RemoteConversationItem>, NablaError>(
                        data: .empty,
                        isDataFresh: false,
                        refreshingState: .refreshing
                    )
                    return Just(initialValue)
                        .setFailureType(to: NablaError.self)
                        .eraseToAnyPublisher()
                }
            }
            .nabla.switchToLatest()
            .eraseToAnyPublisher()
        
        var subscriber: Any? = makeOrReuseConversationEventsSubscription(for: conversationId)
        assert(subscriber != nil) // Silences "Variable `subscriber` was written to, but never read" warning
        
        return Publishers.CombineLatest(localData, remoteData)
            .map { [logger] (localData: [LocalConversationItem], remoteResponse: AnyResponse<PaginatedList<RemoteConversationItem>, NablaError>) in
                remoteResponse.mapData { remoteData in
                    let items = Self.merge(remoteData.elements, localData, logger: logger)
                    return PaginatedList(
                        elements: items,
                        loadMore: remoteData.loadMore
                    )
                }
            }
            .handleEvents(receiveCancel: {
                subscriber = nil
            })
            .eraseToAnyPublisher()
    }
    
    private static func merge(_ remoteItems: [RemoteConversationItem], _ localItems: [LocalConversationItem], logger: Logger) -> [ConversationItem] {
        var localItemsByClientId = localItems.nabla.toDictionary(\.clientId)
        let transformer = RemoteConversationItemTransformer(logger: logger)
        
        var mergedItems = remoteItems.compactMap { remoteItem -> ConversationItem? in
            guard let clientId = remoteItem.clientId else {
                return transformer.transform(remoteItem)
            }
            if let localItem = localItemsByClientId[clientId] {
                localItemsByClientId.removeValue(forKey: localItem.clientId)
                // Always use the remote item as source of truth.
                // Come change this when we support editing messages locally.
                return transformer.transform(remoteItem)
            }
            return transformer.transform(remoteItem)
        }
        let localTransformer = LocalConversationItemTransformer(existingItems: mergedItems)
        let localOnlyItems = localItemsByClientId.values.compactMap(localTransformer.transform(_:))
        mergedItems.append(contentsOf: localOnlyItems)
        return mergedItems.nabla.sorted(\.date, using: >)
    }
    
    /// - Throws: ``NablaError``
    func sendMessage(
        _ messageInput: MessageInput,
        replyToMessageId: UUID?,
        inConversationWithId conversationId: TransientUUID
    ) async throws {
        let localMessage = makeLocalConversationMessage(
            for: messageInput,
            replyToMessageId: replyToMessageId,
            inConversationWithId: conversationId.localId
        )
        itemsLocalDataSource.addConversationItem(localMessage)
        let preparedMessage = try await prepare(localConversationMessage: localMessage)
        try await sendMessage(
            existingLocalConversationMessage: preparedMessage,
            inConversationWithId: conversationId
        )
    }
    
    /// - Throws: ``NablaError``
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId conversationId: TransientUUID
    ) async throws {
        guard let localMessage = itemsLocalDataSource.getConversationItem(
            withClientId: itemId
        ) as? LocalConversationMessage else {
            throw MessageNotFoundError()
        }
        let preparedMessage = try await prepare(localConversationMessage: localMessage)
        try await sendMessage(
            existingLocalConversationMessage: preparedMessage,
            inConversationWithId: conversationId
        )
    }
    
    /// - Throws: ``NablaError``
    func deleteMessage(withId messageId: UUID, conversationId: TransientUUID) async throws {
        itemsLocalDataSource.removeConversationItem(withClientId: messageId)
        guard conversationId.remoteId != nil else { return }
        
        do {
            try await itemsRemoteDataSource.delete(messageId: messageId)
        } catch let error as GQLError {
            throw GQLErrorTransformer.transform(gqlError: error)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    // MARK: - Private
    
    private let itemsRemoteDataSource: ConversationItemRemoteDataSource
    private let itemsLocalDataSource: ConversationItemLocalDataSource
    private let fileUploadRemoteDataSource: FileUploadRemoteDataSource
    private let conversationLocalDataSource: ConversationLocalDataSource
    private let conversationRemoteDataSource: ConversationRemoteDataSource
    private let logger: Logger
    
    private var conversationEventsSubscriptions = [UUID: Weak<ConversationItemsSubscriber>]()
    private var conversationsBeingCreated = [UUID: Task<Void, Error>]()
    
    private func makeOrReuseConversationEventsSubscription(for conversationId: TransientUUID) -> Cancellable {
        // Always store and find subscriptions by `localId` because it is immutable and non-null
        if let subscription = conversationEventsSubscriptions[conversationId.localId]?.value {
            return subscription
        }
        
        let subscription = ConversationItemsSubscriber(
            conversationId: conversationId,
            itemsRemoteDataSource: itemsRemoteDataSource
        )
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
    
    /// - Throws: ``NablaError``
    private func prepare(
        localConversationMessage: LocalConversationMessage
    ) async throws -> LocalConversationMessage {
        do {
            let prepared = try await performPrepare(localConversationItem: localConversationMessage)
            itemsLocalDataSource.updateConversationItem(prepared)
            return prepared
        } catch let error as NablaError {
            var copy = localConversationMessage
            copy.sendingState = .failed
            itemsLocalDataSource.updateConversationItem(copy)
            throw error
        } catch {
            var copy = localConversationMessage
            copy.sendingState = .failed
            itemsLocalDataSource.updateConversationItem(copy)
            throw InternalError(underlyingError: error)
        }
    }
    
    /// - Throws: ``NablaError``
    private func upload(media: Media) async throws -> UUID {
        do {
            return try await fileUploadRemoteDataSource.upload(file: transform(media))
        } catch let error as FileUploadRemoteDataSourceError {
            throw Self.transformFileUploadError(error)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    /// - Throws: ``NablaError``
    private func performPrepare(
        localConversationItem: LocalConversationMessage
    ) async throws -> LocalConversationMessage {
        if let localTextItem = localConversationItem as? LocalTextMessageItem {
            return localTextItem
        } else if let localImageItem = localConversationItem as? LocalImageMessageItem {
            if localImageItem.content.uploadUuid != nil {
                return localImageItem
            } else {
                var copy = localImageItem
                copy.content.uploadUuid = try await upload(media: copy.content.media)
                return copy
            }
        } else if let localDocumentItem = localConversationItem as? LocalDocumentMessageItem {
            if localDocumentItem.content.uploadUuid != nil {
                return localDocumentItem
            } else {
                var copy = localDocumentItem
                copy.content.uploadUuid = try await upload(media: copy.content.media)
                return copy
            }
        } else if let localAudioItem = localConversationItem as? LocalAudioMessageItem {
            if localAudioItem.content.uploadUuid != nil {
                return localAudioItem
            } else {
                var copy = localAudioItem
                copy.content.uploadUuid = try await upload(media: copy.content.media)
                return copy
            }
        } else if let localVideoItem = localConversationItem as? LocalVideoMessageItem {
            if localVideoItem.content.uploadUuid != nil {
                return localVideoItem
            } else {
                var copy = localVideoItem
                copy.content.uploadUuid = try await upload(media: copy.content.media)
                return copy
            }
        }
        
        logger.error(message: "Unknown local conversation item", extra: ["type": type(of: localConversationItem)])
        throw InvalidMessageError()
    }
    
    /// - Throws: ``NablaError``
    private func sendMessage(
        existingLocalConversationMessage localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: TransientUUID
    ) async throws {
        var copy = localConversationMessage
        if let creationTask = conversationsBeingCreated[conversationId.localId] {
            // If conversation is being created, postpone sending the message until it's done.
            copy.sendingState = .toBeSent
            itemsLocalDataSource.updateConversationItem(copy)
            _ = await creationTask.result
        }
        
        if let remoteId = conversationId.remoteId {
            return try await performSend(
                copy,
                inConversationWithId: remoteId
            )
        } else {
            let initialMessage = copy
            let creationTask = Task {
                try await performCreateWithInitialMessage(
                    initialMessage,
                    inConversationWithId: conversationId
                )
            }
            conversationsBeingCreated[conversationId.localId] = creationTask
            switch await creationTask.result {
            case .success: break
            case let .failure(error): throw error
            }
        }
    }
    
    /// - Throws: ``NablaError``
    private func performSend(
        _ localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: UUID
    ) async throws {
        guard let sendInput = makeSendInput(for: localConversationMessage) else {
            throw InvalidMessageError()
        }
        
        var copy = localConversationMessage
        copy.sendingState = .sending
        itemsLocalDataSource.updateConversationItem(copy)
        
        do {
            try await itemsRemoteDataSource.send(
                remoteMessageInput: sendInput,
                conversationId: conversationId
            )
            var copy = localConversationMessage
            copy.sendingState = .sent
            itemsLocalDataSource.updateConversationItem(copy)
        } catch let error as GQLError {
            var copy = localConversationMessage
            copy.sendingState = .failed
            itemsLocalDataSource.updateConversationItem(copy)
            throw GQLErrorTransformer.transform(gqlError: error)
        } catch {
            var copy = localConversationMessage
            copy.sendingState = .failed
            itemsLocalDataSource.updateConversationItem(copy)
            throw InternalError(underlyingError: error)
        }
    }
    
    /// - Throws: ``NablaError``
    private func performCreateWithInitialMessage(
        _ localConversationMessage: LocalConversationMessage,
        inConversationWithId conversationId: TransientUUID
    ) async throws {
        guard let sendInput = makeSendInput(for: localConversationMessage) else {
            throw InvalidMessageError()
        }
        
        if let remoteId = conversationId.remoteId {
            // Last minute check in case the conversation has been created since previous checks
            try await performSend(localConversationMessage, inConversationWithId: remoteId)
        }
        
        var copy = localConversationMessage
        copy.sendingState = .sending
        itemsLocalDataSource.updateConversationItem(copy)
        
        let localConversation = conversationLocalDataSource.getConversation(withId: conversationId.localId)
        if localConversation == nil {
            logger.warning(message: "Will create a conversation with an initial message, but the corresponding local conversation was not found.")
        }
        
        do {
            let remoteConversation = try await conversationRemoteDataSource
                .createConversation(
                    message: sendInput,
                    title: localConversation?.title,
                    providerIds: localConversation?.providerIds
                )
            
            var copy = localConversationMessage
            copy.sendingState = .sent
            itemsLocalDataSource.updateConversationItem(copy)
            
            updateLocalConversation(conversationId: conversationId, with: remoteConversation)
        } catch let error as GQLError {
            markDraftConversationPendingMessagesAsFailed(conversationId: conversationId)
            throw GQLErrorTransformer.transform(gqlError: error)
        } catch {
            markDraftConversationPendingMessagesAsFailed(conversationId: conversationId)
            throw InternalError(underlyingError: error)
        }
        conversationsBeingCreated.removeValue(forKey: conversationId.localId)
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
    
    private static func transformFileUploadError(_ error: FileUploadRemoteDataSourceError) -> NablaError {
        switch error {
        case .cannotReadFileData:
            return CanNotReadFileDataError()
        case let .uploadError(error):
            return ServerError(underlyingError: error)
        case let .unknownError(error):
            return ServerError(underlyingError: error)
        }
    }
    
    private func transform(_ media: Media) -> RemoteFileUpload {
        .init(
            fileName: media.fileName,
            content: media.content,
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
    }
    
    init(
        conversationId: TransientUUID,
        itemsRemoteDataSource: ConversationItemRemoteDataSource
    ) {
        self.conversationId = conversationId
        self.itemsRemoteDataSource = itemsRemoteDataSource
        
        beginSubscription()
    }
    
    deinit {
        cancel()
    }
    
    private let conversationId: TransientUUID
    private let itemsRemoteDataSource: ConversationItemRemoteDataSource
    
    private var subscription: AnyCancellable?
    
    private func beginSubscription() {
        subscription = conversationId.observeRemoteId()
            .compactMap { $0 }
            .map { [itemsRemoteDataSource] remoteId -> AnyPublisher<RemoteConversationEvent, Never> in
                itemsRemoteDataSource.subscribeToConversationItemsEvents(ofConversationWithId: remoteId)
            }
            .switchToLatest()
            .nabla.sink()
    }
}
