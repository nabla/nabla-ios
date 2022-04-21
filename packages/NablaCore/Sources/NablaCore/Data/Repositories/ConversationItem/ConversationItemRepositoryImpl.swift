import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> Cancellable {
        let merger = ConversationItemsMerger(conversationId: conversationId, callback: callback)
        merger.resume()
        
        let eventsSubscription = makeOrReuseConversationEventsSubscription(for: conversationId)
        merger.hold(eventsSubscription)
        
        return merger
    }

    func sendMessage(_ message: MessageInput, conversationId: UUID, callback: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        let localConversationItem: LocalConversationItem
        switch message {
        case let .text(content):
            localConversationItem = LocalTextMessageItem(
                clientId: UUID(),
                date: Date(),
                sender: .patient,
                state: .sending,
                content: content
            )
        }
        localDataSource.addConversationItem(localConversationItem, toConversationWithId: conversationId)
        return remoteDataSource.send(
            localMessageClientId: localConversationItem.clientId,
            remoteMessageInput: Self.transform(message),
            conversationId: conversationId,
            callback: callback
        )
    }

    // MARK: - Private
    
    @Inject private var remoteDataSource: ConversationItemRemoteDataSource
    @Inject private var localDataSource: ConversationItemLocalDataSource
    
    private var conversationEventsSubscriptions = [UUID: WeakCancellable]()
    
    private func makeOrReuseConversationEventsSubscription(for conversationId: UUID) -> Cancellable {
        if let subscription = conversationEventsSubscriptions[conversationId]?.value {
            return subscription
        }
        
        let subscription = remoteDataSource.subscribeToConversationItemsEvents(ofConversationWithId: conversationId) { _ in }
        conversationEventsSubscriptions[conversationId] = WeakCancellable(value: subscription)
        return subscription
    }
    
    private static func transform(_ messageInput: MessageInput) -> GQL.SendMessageContentInput {
        switch messageInput {
        case let .text(content):
            return .init(textInput: .init(text: content))
        }
    }
}

private struct WeakCancellable {
    weak var value: Cancellable?
}
