import Foundation
@testable import NablaMessagingCore

extension LocalTextMessageItem {
    static func mock(
        dateOffset: TimeInterval = 0,
        sendingState: ConversationMessageSendingState = .sending
    ) -> LocalTextMessageItem {
        itemCount += 1
        return LocalTextMessageItem(
            clientId: .init(),
            date: Date(timeIntervalSinceReferenceDate: dateOffset),
            sendingState: sendingState,
            content: "Hello world \(itemCount)"
        )
    }
    
    private static var itemCount = 0
}
