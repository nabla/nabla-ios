import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
    ) -> Cancellable {
        let merger = ConversationItemsMerger(conversationId: conversationId, callback: callback)
        merger.resume()
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription(for: conversationId)
        merger.hold(eventsSubscription)
        
        return merger
    }

    func sendMessage(
        _ input: MessageInput,
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

    // MARK: - Private
    
    @Inject private var remoteDataSource: ConversationItemRemoteDataSource
    @Inject private var localDataSource: ConversationItemLocalDataSource
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
        logger.warning(message: "Sending \(type(of: localConversationItem)) is not supported yet")
        return nil
    }
    
    private func makeLocalConversationItem(for input: MessageInput) -> LocalConversationItem {
        switch input {
        case let .text(content):
            return LocalTextMessageItem(
                clientId: UUID(),
                date: Date(),
                sender: .patient,
                state: .sending,
                content: content
            )
        }
    }
    
    private func performSend(
        _ localConversationItem: LocalConversationItem,
        inConversationWithId conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        guard let input = makeSendInput(for: localConversationItem) else {
            completion(.failure(ConversationItemRepositoryError.notSupported))
            return Failure()
        }
        return remoteDataSource.send(
            localMessageClientId: localConversationItem.clientId,
            remoteMessageInput: input,
            conversationId: conversationId
        ) { [localDataSource] result in
            switch result {
            case let .failure(error):
                var copy = localConversationItem
                copy.state = .failed
                localDataSource.updateConversationItem(copy, inConversationWithId: conversationId)
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
