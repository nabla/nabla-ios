import Foundation
@testable import NablaMessagingCore

extension LocalTextMessageItem {
    static func mock(
        conversationId: UUID = .init(),
        dateOffset: TimeInterval = 0,
        sendingState: ConversationMessageSendingState = .sending
    ) -> LocalTextMessageItem {
        itemCount += 1
        return LocalTextMessageItem(
            conversationId: conversationId,
            clientId: .init(),
            date: Date(timeIntervalSinceReferenceDate: dateOffset),
            sendingState: sendingState,
            replyToUuid: nil,
            content: "Hello world \(itemCount)"
        )
    }
    
    private static var itemCount = 0
}
