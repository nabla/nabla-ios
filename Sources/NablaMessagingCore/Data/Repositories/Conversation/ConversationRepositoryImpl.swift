import Combine
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
    
    func watchConversation(withId conversationId: TransientUUID) -> AnyPublisher<AnyResponse<Conversation, NablaError>, NablaError> {
        let localConversation = localDataSource.watchConversation(conversationId.localId)
            .setFailureType(to: NablaError.self)
        
        let remoteConversation = conversationId.observeRemoteId()
            .nabla.switchToLatest { [remoteDataSource] remoteId -> AnyPublisher<AnyResponse<RemoteConversation, NablaError>?, NablaError> in
                if let remoteId = remoteId {
                    return remoteDataSource.watchConversation(remoteId)
                        .map { response in
                            response.mapError(GQLErrorTransformer.transform(gqlError:))
                        }
                        .nabla.asOptional()
                        .mapError(GQLErrorTransformer.transform(gqlError:))
                        .eraseToAnyPublisher()
                } else {
                    return Just(nil)
                        .setFailureType(to: NablaError.self)
                        .eraseToAnyPublisher()
                }
            }
        
        return Publishers.CombineLatest(localConversation, remoteConversation)
            .map { localConversation, remoteResponse -> AnyResponse<Conversation, NablaError>? in
                if let remoteResponse = remoteResponse {
                    return remoteResponse.mapData { remoteConversation in
                        ConversationTransformer.transform(fragment: remoteConversation)
                    }
                } else if let localConversation = localConversation {
                    return AnyResponse(
                        data: ConversationTransformer.transform(conversation: localConversation),
                        isDataFresh: true,
                        refreshingState: .refreshed
                    )
                } else {
                    return nil
                }
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    func watchConversations() -> AnyPublisher<AnyResponse<PaginatedList<Conversation>, NablaError>, NablaError> {
        let watcher = remoteDataSource.watchConversations()
            .mapError(GQLErrorTransformer.transform(gqlError:))
            .map { response in
                response.map(
                    data: { paginatedList in
                        paginatedList.map(ConversationTransformer.transform(fragment:))
                    },
                    error: GQLErrorTransformer.transform(gqlError:)
                )
            }
            .eraseToAnyPublisher()
        
        var subscription: AnyCancellable? = makeOrReuseConversationEventsSubscription()
        assert(subscription != nil) // Silences "Variable 'subscription' was written to, but never read" warning
        
        return watcher
            .handleEvents(receiveCancel: {
                subscription = nil
            })
            .eraseToAnyPublisher()
    }
    
    /// - Throws: ``NablaError``
    func createConversation(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?
    ) async throws -> Conversation {
        let input = try await prepareInitialMessage(message)
        do {
            let conversation = try await remoteDataSource.createConversation(message: input, title: title, providerIds: providerIds)
            return ConversationTransformer.transform(fragment: conversation)
        } catch let error as GQLError {
            switch error {
            case let .entityNotFound(message):
                throw ProviderNotFoundError(message: message)
            case let .permissionRequired(message):
                throw ProviderMissingPermissionError(message: message)
            default:
                throw GQLErrorTransformer.transform(gqlError: error)
            }
        } catch {
            throw InternalError(underlyingError: error)
        }
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

    private weak var conversationsEventsSubscription: AnyCancellable?
    
    private func makeOrReuseConversationEventsSubscription() -> AnyCancellable {
        if let subscription = conversationsEventsSubscription {
            return subscription
        }
        
        let subscription = remoteDataSource.subscribeToConversationsEvents()
            .nabla.sink()
        conversationsEventsSubscription = subscription
        return subscription
    }
    
    /// - Throws: ``NablaError``
    private func prepareInitialMessage(
        _ message: MessageInput
    ) async throws -> GQL.SendMessageInput {
        let clientId = uuidGenerator.generate()
        switch message {
        case let .text(content):
            return GQL.SendMessageInput(
                content: .init(textInput: .some(.init(text: content))),
                clientId: clientId
            )
        case let .image(content):
            let uuid = try await upload(media: content)
            return .init(
                content: .init(imageInput: .some(.init(upload: .init(uuid: uuid)))),
                clientId: clientId
            )
        case let .video(content):
            let uuid = try await upload(media: content)
            return .init(
                content: .init(videoInput: .some(.init(upload: .init(uuid: uuid)))),
                clientId: clientId
            )
        case let .document(content):
            let uuid = try await upload(media: content)
            return .init(
                content: .init(documentInput: .some(.init(upload: .init(uuid: uuid)))),
                clientId: clientId
            )
        case let .audio(content):
            let uuid = try await upload(media: content)
            return .init(
                content: .init(audioInput: .some(.init(upload: .init(uuid: uuid)))),
                clientId: clientId
            )
        }
    }
    
    /// - Throws: ``NablaError``
    private func upload(media: Media) async throws -> UUID {
        do {
            return try await fileUploadDataSource.upload(file: transform(media))
        } catch let error as FileUploadRemoteDataSourceError {
            throw Self.transformFileUploadError(error)
        } catch {
            throw InternalError(underlyingError: error)
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
