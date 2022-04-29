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
        _ input: RemoteMessageInput,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        let localConversationItem = makeLocalConversationItem(for: input)
        localDataSource.addConversationItem(localConversationItem, toConversationWithId: conversationId)
        return performSend(localConversationItem, inConversationWithId: conversationId, completion: completion)
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
        return performSend(localConversationItem, inConversationWithId: conversationId, completion: completion)
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
        if let imageMessage = localConversationItem as? LocalImageMessageItem {
            return .init(imageInput: .init(upload: .init(uuid: imageMessage.content.fileUploadUUID)))
        }
        
        if let documentMessage = localConversationItem as? LocalDocumentMessageItem {
            return .init(documentInput: .init(upload: .init(uuid: documentMessage.content.fileUploadUUID)))
        }
        logger.warning(message: "Sending \(type(of: localConversationItem)) is not supported yet")
        return nil
    }
    
    private func makeLocalConversationItem(for input: RemoteMessageInput) -> LocalConversationItem {
        switch input {
        case let .text(content):
            return LocalTextMessageItem(
                clientId: UUID(),
                date: Date(),
                sender: .patient,
                state: .sending,
                content: content
            )
        case let .image(image):
            return LocalImageMessageItem(
                clientId: UUID(),
                date: Date(),
                sender: .patient,
                state: .sending,
                content: image
            )
        case let .document(content: document):
            return LocalDocumentMessageItem(
                clientId: UUID(),
                date: Date(),
                sender: .patient,
                state: .sending,
                content: document
            )
        }
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

private struct WeakCancellable {
    weak var value: Cancellable?
}
