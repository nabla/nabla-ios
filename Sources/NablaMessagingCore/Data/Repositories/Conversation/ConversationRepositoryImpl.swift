import Foundation
import NablaCore

class ConversationRepositoryImpl: ConversationRepository {
    // MARK: - Initializer

    init(
        remoteDataSource: ConversationRemoteDataSource,
        localDataSource: ConversationLocalDataSource,
        fileUploadDataSource: FileUploadRemoteDataSource,
        uuidGenerator: UUIDGenerator
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.fileUploadDataSource = fileUploadDataSource
        self.uuidGenerator = uuidGenerator
    }

    // MARK: - Internal
    
    func getConversationTransientId(from id: UUID) -> TransientUUID {
        if let localConversation = localDataSource.getConversation(withId: id) {
            return TransientUUID(localId: localConversation.id, remoteId: localConversation.remoteId)
        } else {
            return TransientUUID(remoteId: id)
        }
    }
    
    func watchConversation(
        withId conversationId: TransientUUID,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Watcher {
        ConversationWatcher(
            conversationId: conversationId,
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            handler: .init { [weak self] result in
                switch result {
                case let .failure(error):
                    handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
                case let .success(conversation):
                    if conversation.providers.contains(where: \.isTyping) {
                        self?.remoteTypingDebouncer.execute {
                            handler(.success(conversation))
                        }
                    } else {
                        self?.remoteTypingDebouncer.cancel()
                    }
                    handler(.success(conversation))
                }
            }
        )
    }
    
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher {
        let watcher = remoteDataSource.watchConversations(handler: .init { result in
            switch result {
            case let .failure(error):
                handler(.failure(GQLErrorTransformer.transform(gqlError: error)))
            case let .success(data):
                let model = ConversationList(
                    conversations: ConversationTransformer.transform(data: data),
                    hasMore: data.conversations.hasMore
                )
                handler(.success(model))
            }
        })

        let holder = PaginatedWatcherAndSubscriptionHolder(watcher: watcher)
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription()
        holder.hold(eventsSubscription)
        
        return holder
    }
    
    func createConversation(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> NablaCancellable {
        let umbrella = UmbrellaCancellable()
        
        let prepareTask = prepareInitialMessage(
            message,
            handler: .init { [weak umbrella, remoteDataSource] result in
                guard let umbrella = umbrella, !umbrella.isCancelled else { return }
                
                switch result {
                case let .failure(error):
                    handler(.failure(error))
                case let .success(messageInput):
                    let createTask = remoteDataSource.createConversation(
                        message: messageInput,
                        title: title,
                        providerIds: providerIds,
                        handler: handler
                            .pullbackError { error in
                                switch error {
                                case let .entityNotFound(message):
                                    return ProviderNotFoundError(message: message)
                                case let .permissionRequired(message):
                                    return ProviderMissingPermissionError(message: message)
                                default:
                                    return GQLErrorTransformer.transform(gqlError: error)
                                }
                            }
                            .pullback(ConversationTransformer.transform)
                    )
                    umbrella.add(createTask)
                }
            }
        )
        umbrella.add(prepareTask)
        return umbrella
    }
    
    func startConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation {
        let localConversation = localDataSource.startConversation(title: title, providerIds: providerIds)
        return ConversationTransformer.transform(conversation: localConversation)
    }
    
    /// - Throws: ``NablaError``
    func setIsTyping(_ isTyping: Bool, conversationId: TransientUUID) async throws {
        guard let remoteId = conversationId.remoteId else { return }
        
        do {
            try await remoteDataSource.setIsTyping(isTyping, conversationId: remoteId)
        } catch let error as GQLError {
            throw GQLErrorTransformer.transform(gqlError: error)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    /// - Throws: ``NablaError``
    func markConversationAsSeen(conversationId: TransientUUID) async throws {
        guard let remoteId = conversationId.remoteId else { return }
        
        do {
            try await remoteDataSource.markConversationAsSeen(conversationId: remoteId)
        } catch let error as GQLError {
            throw GQLErrorTransformer.transform(gqlError: error)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    // MARK: - Private

    private let uuidGenerator: UUIDGenerator
    private let remoteDataSource: ConversationRemoteDataSource
    private let localDataSource: ConversationLocalDataSource
    private let fileUploadDataSource: FileUploadRemoteDataSource

    private weak var conversationsEventsSubscription: NablaCancellable?
    private let remoteTypingDebouncer: Debouncer = .init(
        delay: ProviderInConversation.Constants.typingTimeWindowTimeInterval,
        queue: .global(qos: .userInitiated)
    )
    
    private func makeOrReuseConversationEventsSubscription() -> NablaCancellable {
        if let subscription = conversationsEventsSubscription {
            return subscription
        }
        
        let subscription = remoteDataSource.subscribeToConversationsEvents(handler: .void)
        conversationsEventsSubscription = subscription
        return subscription
    }
    
    private func prepareInitialMessage(
        _ message: MessageInput?,
        handler: ResultHandler<GQL.SendMessageInput?, NablaError>
    ) -> NablaCancellable {
        guard let message = message else {
            return Success(handler: handler, value: nil)
        }
        
        let clientId = uuidGenerator.generate()
        switch message {
        case let .text(content):
            let input = GQL.SendMessageInput(content: .init(textInput: .init(text: content)), clientId: clientId)
            return Success(handler: handler, value: input)
        case let .image(content):
            return fileUploadDataSource.upload(
                file: transform(content),
                handler: handler
                    .pullbackError(Self.transformFileUploadError(_:))
                    .pullback { .init(content: .init(imageInput: .init(upload: .init(uuid: $0))), clientId: clientId) }
            )
        case let .video(content):
            return fileUploadDataSource.upload(
                file: transform(content),
                handler: handler
                    .pullbackError(Self.transformFileUploadError(_:))
                    .pullback { .init(content: .init(videoInput: .init(upload: .init(uuid: $0))), clientId: clientId) }
            )
        case let .document(content):
            return fileUploadDataSource.upload(
                file: transform(content),
                handler: handler
                    .pullbackError(Self.transformFileUploadError(_:))
                    .pullback { .init(content: .init(documentInput: .init(upload: .init(uuid: $0))), clientId: clientId) }
            )
        case let .audio(content):
            return fileUploadDataSource.upload(
                file: transform(content),
                handler: handler
                    .pullbackError(Self.transformFileUploadError(_:))
                    .pullback { .init(content: .init(audioInput: .init(upload: .init(uuid: $0))), clientId: clientId) }
            )
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
}
