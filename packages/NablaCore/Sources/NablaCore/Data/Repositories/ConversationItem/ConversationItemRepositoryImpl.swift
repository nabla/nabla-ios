import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> Cancellable {
        let merger = ConversationItemsMerger(conversationId: conversationId, callback: callback)
        merger.resume()
        return merger
    }

    func sendMessage(_ message: MessageInput, conversationId: UUID, callback: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        let localConversationItem: LocalConversationItem
        switch message {
        case let .text(content):
            localConversationItem = LocalTextMessageItem(
                clientId: UUID(),
                date: Date(),
                sender: .me,
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

    private static func transform(_ messageInput: MessageInput) -> GQL.SendMessageContentInput {
        switch messageInput {
        case let .text(content):
            return .init(textInput: .init(text: content))
        }
    }
}
