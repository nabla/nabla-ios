import Foundation
@testable import NablaMessagingCore

public extension TextMessageItem {
    static func mock(
        dateOffset: TimeInterval = 0,
        sender: ConversationMessageSender = .deleted
    ) -> TextMessageItem {
        itemCount += 1
        return TextMessageItem(
            id: .init(),
            date: Date(timeIntervalSinceReferenceDate: dateOffset),
            sender: sender,
            sendingState: .sent,
            replyTo: nil,
            content: "Hello world \(itemCount)"
        )
    }
    
    private static var itemCount = 0
}
