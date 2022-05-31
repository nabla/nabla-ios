import Foundation

enum LocalConversationItemTransformer {
    static func transform(_ localConversationItem: LocalConversationItem) -> ConversationItem? {
        if let textMessageItem = localConversationItem as? LocalTextMessageItem {
            return TextMessageItem(
                id: textMessageItem.clientId,
                date: textMessageItem.date,
                sender: .patient,
                sendingState: textMessageItem.sendingState,
                content: textMessageItem.content
            )
        } else if let deletedMessageItem = localConversationItem as? LocalDeletedMessageItem {
            return DeletedMessageItem(
                id: deletedMessageItem.clientId,
                date: deletedMessageItem.date,
                sender: .patient,
                sendingState: deletedMessageItem.sendingState
            )
        }
        if let imageMessageItem = localConversationItem as? LocalImageMessageItem {
            return ImageMessageItem(
                id: imageMessageItem.clientId,
                date: imageMessageItem.date,
                sender: .patient,
                sendingState: imageMessageItem.sendingState,
                content: imageMessageItem.content.media
            )
        }
        if let documentMessageItem = localConversationItem as? LocalDocumentMessageItem {
            return DocumentMessageItem(
                id: documentMessageItem.clientId,
                date: documentMessageItem.date,
                sender: .patient,
                sendingState: documentMessageItem.sendingState,
                content: documentMessageItem.content.media
            )
        }

        if let audioMessageItem = localConversationItem as? LocalAudioMessageItem {
            return AudioMessageItem(
                id: audioMessageItem.clientId,
                date: audioMessageItem.date,
                sender: .patient,
                sendingState: audioMessageItem.sendingState,
                content: AudioFile(media: audioMessageItem.content.media, durationMs: audioMessageItem.content.durationMs)
            )
        }

        assertionFailure("Unknown local conversation item \(localConversationItem)")
        return nil
    }
}

extension LocalMediaMessageItemContent {
    var durationMs: Int {
        switch self {
        case .media, .uploadedMedia:
            return 0
        case let .audioFile(audioFile):
            return audioFile.durationMs
        }
    }
}
