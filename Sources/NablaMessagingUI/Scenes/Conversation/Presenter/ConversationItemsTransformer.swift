import Foundation
import NablaCore
import NablaMessagingCore

enum ConversationItemsTransformer {
    static func transform(
        conversationItems: PaginatedList<ConversationItem>,
        providers: [ProviderInConversation],
        focusedTextItemId: UUID?
    ) -> [ConversationViewItem] {
        var viewItems = [ConversationViewItem]()

        let contentItems = conversationItems.elements.compactMap(transform)
        viewItems.append(contentsOf: contentItems)
        
        let typingItems = providers
            .filter(\.isTyping)
            .map {
                TypingIndicatorViewItem(sender: .provider($0.provider))
            }
        viewItems.insert(contentsOf: typingItems, at: 0)

        groupByDateAndSender(&viewItems)
        focusOnTextItemIfNeeded(&viewItems, focusedTextItemId: focusedTextItemId)
        if conversationItems.hasMore {
            viewItems.append(HasMoreIndicatorViewItem())
        }
        return viewItems
    }

    // MARK: - Private

    private static func transform(item: ConversationItem) -> ConversationViewItem? {
        if let textMessage = item as? TextMessageItem {
            return Self.transform(textMessage)
        } else if let deletedMessage = item as? DeletedMessageItem {
            return Self.transform(deletedMessage)
        } else if let imageMessage = item as? ImageMessageItem {
            return Self.transform(imageMessage)
        } else if let documentMessage = item as? DocumentMessageItem {
            return Self.transform(documentMessage)
        } else if let activity = item as? ConversationActivity {
            return Self.transform(activity)
        } else if let audioMessage = item as? AudioMessageItem {
            return transform(audioMessage)
        } else if let videoMessage = item as? VideoMessageItem {
            return transform(videoMessage)
        } else if let videoCallRoomInteractiveMessage = item as? VideoCallRoomInteractiveMessage {
            return transform(videoCallRoomInteractiveMessage)
        }
        return nil
    }

    private static func transform(_ textMessage: TextMessageItem) -> ConversationViewItem {
        TextMessageViewItem(
            id: textMessage.id,
            date: textMessage.date,
            sender: textMessage.sender,
            sendingState: textMessage.sendingState,
            replyTo: textMessage.replyTo.flatMap(transform(item:)) as? ConversationViewMessageItem,
            text: textMessage.content
        )
    }

    private static func transform(_ deletedMessage: DeletedMessageItem) -> ConversationViewItem {
        DeletedMessageViewItem(
            id: deletedMessage.id,
            date: deletedMessage.date,
            sender: deletedMessage.sender,
            sendingState: deletedMessage.sendingState,
            replyTo: deletedMessage.replyTo.flatMap(transform(item:)) as? ConversationViewMessageItem
        )
    }

    private static func transform(_ imageMessage: ImageMessageItem) -> ConversationViewItem {
        ImageMessageViewItem(
            id: imageMessage.id,
            date: imageMessage.date,
            sender: imageMessage.sender,
            sendingState: imageMessage.sendingState,
            replyTo: imageMessage.replyTo.flatMap(transform(item:)) as? ConversationViewMessageItem,
            image: imageMessage.content
        )
    }

    private static func transform(_ documentMessage: DocumentMessageItem) -> ConversationViewItem {
        DocumentMessageViewItem(
            id: documentMessage.id,
            date: documentMessage.date,
            sender: documentMessage.sender,
            sendingState: documentMessage.sendingState,
            replyTo: documentMessage.replyTo.flatMap(transform(item:)) as? ConversationViewMessageItem,
            document: documentMessage.content
        )
    }

    private static func transform(_ activity: ConversationActivity) -> ConversationViewItem {
        ConversationActivityViewItem(
            id: activity.id,
            date: activity.date,
            activity: activity.activity
        )
    }

    static func transform(_ audioMessage: AudioMessageItem) -> ConversationViewItem {
        AudioMessageViewItem(
            id: audioMessage.id,
            date: audioMessage.date,
            sender: audioMessage.sender,
            sendingState: audioMessage.sendingState,
            replyTo: audioMessage.replyTo.flatMap(transform(item:)) as? ConversationViewMessageItem,
            audio: audioMessage.content
        )
    }

    static func transform(_ videoMessage: VideoMessageItem) -> ConversationViewItem {
        VideoMessageViewItem(
            id: videoMessage.id,
            date: videoMessage.date,
            sender: videoMessage.sender,
            sendingState: videoMessage.sendingState,
            replyTo: videoMessage.replyTo.flatMap(transform(item:)) as? ConversationViewMessageItem,
            video: videoMessage.content
        )
    }
    
    static func transform(_ videoCallRoomInteractiveMessage: VideoCallRoomInteractiveMessage) -> ConversationViewItem {
        let room: VideoCallActionRequestViewItem.Room? = {
            switch videoCallRoomInteractiveMessage.status {
            case .closed: return nil
            case let .open(room): return .init(url: room.url, token: room.token)
            }
        }()
        
        return VideoCallActionRequestViewItem(
            id: videoCallRoomInteractiveMessage.id,
            date: videoCallRoomInteractiveMessage.date,
            sender: videoCallRoomInteractiveMessage.sender,
            sendingState: .sent,
            room: room
        )
    }

    private static func groupByDateAndSender(_ viewItems: inout [ConversationViewItem]) {
        if let lastItem = viewItems.last as? ConversationViewMessageItem {
            viewItems.append(DateSeparatorViewItem(id: UUID(), date: lastItem.date))
        }
        
        var insertedItemsCount = 0
        zip(viewItems, viewItems.dropFirst()).enumerated().forEach { arg in
            let (index, tuple) = arg
            let (current, previous) = tuple
            guard
                let previousItem = previous as? ConversationViewMessageItem,
                var currentItem = current as? ConversationViewMessageItem else {
                return
            }
            currentItem.isContiguous = previousItem.sender == currentItem.sender
            viewItems[index + insertedItemsCount] = currentItem
            guard Calendar.current.areDatesAtLeastAnHourApart(currentItem.date, previousItem.date) else {
                return
            }
            currentItem.isContiguous = false
            viewItems[index + insertedItemsCount] = currentItem
            viewItems.insert(DateSeparatorViewItem(id: UUID(), date: currentItem.date), at: index + 1 + insertedItemsCount)
            insertedItemsCount += 1
        }
    }

    private static func focusOnTextItemIfNeeded(_ viewItems: inout [ConversationViewItem], focusedTextItemId: UUID?) {
        guard let focusedTextItemId = focusedTextItemId else { return }
        guard let focusedTextItemAndIndex = viewItems.enumerated().first(
            where: { $0.element.id == focusedTextItemId }
        )
        else { return }
        guard var focusedTextItem = focusedTextItemAndIndex.element as? ConversationViewMessageItem else { return }
        focusedTextItem.isFocused = true
        viewItems[focusedTextItemAndIndex.offset] = focusedTextItem

        guard focusedTextItem.isContiguous else { return }

        viewItems.insert(
            DateSeparatorViewItem(
                id: UUID(),
                date: focusedTextItem.date
            ),
            at: focusedTextItemAndIndex.offset + 1
        )
    }
}
