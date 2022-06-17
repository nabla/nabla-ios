import Foundation

struct LocalConversationItemTransformer {
    // MARK: - Initializer

    init(existingItems: [ConversationItem]) {
        self.existingItems = existingItems.toDictionary(\.id)
    }

    // MARK: - Public

    func transform(_ localConversationItem: LocalConversationItem) -> ConversationItem? {
        if let textMessageItem = localConversationItem as? LocalTextMessageItem {
            return TextMessageItem(
                id: textMessageItem.clientId,
                date: textMessageItem.date,
                sender: .patient,
                sendingState: textMessageItem.sendingState,
                replyTo: textMessageItem.replyToUuid.flatMap { existingItems[$0] as? ConversationMessage },
                content: textMessageItem.content
            )
        } else if let deletedMessageItem = localConversationItem as? LocalDeletedMessageItem {
            return DeletedMessageItem(
                id: deletedMessageItem.clientId,
                date: deletedMessageItem.date,
                sender: .patient,
                sendingState: deletedMessageItem.sendingState,
                replyTo: deletedMessageItem.replyToUuid.flatMap { existingItems[$0] as? ConversationMessage }
            )
        }
        if let imageMessageItem = localConversationItem as? LocalImageMessageItem {
            return ImageMessageItem(
                id: imageMessageItem.clientId,
                date: imageMessageItem.date,
                sender: .patient,
                sendingState: imageMessageItem.sendingState,
                replyTo: imageMessageItem.replyToUuid.flatMap { existingItems[$0] as? ConversationMessage },
                content: imageMessageItem.content.media
            )
        }
        if let documentMessageItem = localConversationItem as? LocalDocumentMessageItem {
            return DocumentMessageItem(
                id: documentMessageItem.clientId,
                date: documentMessageItem.date,
                sender: .patient,
                sendingState: documentMessageItem.sendingState,
                replyTo: documentMessageItem.replyToUuid.flatMap { existingItems[$0] as? ConversationMessage },
                content: documentMessageItem.content.media
            )
        }

        if let audioMessageItem = localConversationItem as? LocalAudioMessageItem {
            return AudioMessageItem(
                id: audioMessageItem.clientId,
                date: audioMessageItem.date,
                sender: .patient,
                sendingState: audioMessageItem.sendingState,
                replyTo: audioMessageItem.replyToUuid.flatMap { existingItems[$0] as? ConversationMessage },
                content: audioMessageItem.content.media
            )
        }

        if let videoMessageItem = localConversationItem as? LocalVideoMessageItem {
            return VideoMessageItem(
                id: videoMessageItem.clientId,
                date: videoMessageItem.date,
                sender: .patient,
                sendingState: videoMessageItem.sendingState,
                replyTo: videoMessageItem.replyToUuid.flatMap { existingItems[$0] as? ConversationMessage },
                content: videoMessageItem.content.media
            )
        }

        assertionFailure("Unknown local conversation item \(localConversationItem)")
        return nil
    }

    // MARK: - Private

    private let existingItems: [UUID: ConversationItem]
}
