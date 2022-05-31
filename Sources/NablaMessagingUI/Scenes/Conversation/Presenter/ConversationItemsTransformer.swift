import Foundation
import NablaMessagingCore

final class ConversationItemsTransformer {
    static func transform(conversationItems: ConversationItems, conversation: Conversation) -> [ConversationViewItem] {
        var viewItems = [ConversationViewItem]()

        if conversationItems.hasMore {
            viewItems.append(HasMoreIndicatorViewItem())
        }

        let contentItems = conversationItems.items.compactMap { item -> ConversationViewItem? in
            if let textMessage = item as? TextMessageItem {
                return transform(textMessage)
            } else if let deletedMessage = item as? DeletedMessageItem {
                return transform(deletedMessage)
            } else if let imageMessage = item as? ImageMessageItem {
                return transform(imageMessage)
            } else if let documentMessage = item as? DocumentMessageItem {
                return transform(documentMessage)
            } else if let activity = item as? ConversationActivity {
                return transform(activity)
            } else if let audioMessage = item as? AudioMessageItem {
                return transform(audioMessage)
            }
            return nil
        }
        viewItems.append(contentsOf: contentItems)
        
        let typingItems = conversation.providers
            .filter(\.isTyping)
            .map {
                TypingIndicatorViewItem(sender: .provider($0.provider))
            }

        viewItems.append(contentsOf: typingItems)

        groupByDateAndSender(&viewItems)
        return viewItems
    }
    
    static func transform(_ textMessage: TextMessageItem) -> ConversationViewItem {
        TextMessageViewItem(
            id: textMessage.id,
            date: textMessage.date,
            sender: textMessage.sender,
            sendingState: textMessage.sendingState,
            text: textMessage.content
        )
    }
    
    static func transform(_ deletedMessage: DeletedMessageItem) -> ConversationViewItem {
        DeletedMessageViewItem(
            id: deletedMessage.id,
            date: deletedMessage.date,
            sender: deletedMessage.sender,
            sendingState: deletedMessage.sendingState
        )
    }
    
    static func transform(_ imageMessage: ImageMessageItem) -> ConversationViewItem {
        ImageMessageViewItem(
            id: imageMessage.id,
            date: imageMessage.date,
            sender: imageMessage.sender,
            sendingState: imageMessage.sendingState,
            image: imageMessage.content
        )
    }
    
    static func transform(_ documentMessage: DocumentMessageItem) -> ConversationViewItem {
        DocumentMessageViewItem(
            id: documentMessage.id,
            date: documentMessage.date,
            sender: documentMessage.sender,
            sendingState: documentMessage.sendingState,
            document: documentMessage.content
        )
    }

    static func transform(_ activity: ConversationActivity) -> ConversationViewItem {
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
            audio: audioMessage.content
        )
    }
    
    private static func groupByDateAndSender(_ viewItems: inout [ConversationViewItem]) {
        if let firstItem = viewItems.first as? ConversationViewMessageItem {
            viewItems.insert(DateSeparatorViewItem(id: UUID(), date: firstItem.date), at: 0)
        }
        
        var insertedItemsCount = 0
        zip(viewItems, viewItems.dropFirst()).enumerated().forEach { arg in
            let (index, tuple) = arg
            let (previous, current) = tuple
            guard
                let previousItem = previous as? ConversationViewMessageItem,
                var currentItem = current as? ConversationViewMessageItem else {
                return
            }
            currentItem.isContiguous = previousItem.sender == currentItem.sender
            viewItems[index + 1 + insertedItemsCount] = currentItem
            guard Calendar.current.areDatesMoreThanAnHourApart(previousItem.date, currentItem.date) else {
                return
            }
            currentItem.isContiguous = false
            viewItems[index + 1 + insertedItemsCount] = currentItem
            viewItems.insert(DateSeparatorViewItem(id: UUID(), date: currentItem.date), at: index + 1)
            insertedItemsCount += 1
        }
    }
}
